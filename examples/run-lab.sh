#!/bin/bash
# Vim for Mere Mortals — lab driver.
# Every demo runs the real vim on this machine against a fresh copy of a
# fixture, and the transcript records the command, the file before, the
# file after, and the diff between them. Nothing is typed by hand.
set -u
exec </dev/null   # nothing in this lab reads the terminal; see show() below
LAB="$HOME/workspace/vim-lab"
FIX="$LAB/fixtures"
WORK="$LAB/work"
TR="$LAB/transcripts"
VIM="vim -Nu NONE -n -i NONE -es"
rm -rf "$WORK"; mkdir -p "$WORK" "$TR"

hdr() { printf '=== %s ===\n' "$1"; }
# show LABEL FILE prints a labelled file. With FILE=/dev/null it prints
# stdin instead -- that is how the 'command' sections get their text from
# a herestring. (The first version of this script catted /dev/null and
# silently swallowed every command line; fixed, transcripts regenerated.)
show() { printf -- '--- %s ---\n' "$1"; if [ "$2" = /dev/null ]; then cat; else cat "$2"; fi; }

# ---------------------------------------------------------------- 01 version
{
  hdr "01 - the vim on this machine, and its built-in tutor"
  show "command" /dev/null <<<'$ vim --version | head -3'
  vim --version | head -3
  show "command" /dev/null <<<'$ command -v vim vimtutor'
  command -v vim vimtutor
  show "command" /dev/null <<<'$ head -8 /usr/share/vim/vim91/tutor/tutor'
  head -8 /usr/share/vim/vim91/tutor/tutor
} > "$TR/01-version-and-tutor.txt" 2>&1

# ------------------------------------------------------------- 02 substitute
{
  hdr "02 - search and replace across a whole file"
  cp "$FIX/notes.txt" "$WORK/notes.txt"
  show "command" /dev/null <<<'$ vim -Nu NONE -n -i NONE -es notes.txt -c "%s/teh/the/ge" -c "wq"'
  show "before" "$WORK/notes.txt"
  ( cd "$WORK" && $VIM notes.txt -c '%s/teh/the/ge' -c 'wq' )
  show "after :%s/teh/the/ge" "$WORK/notes.txt"
  show "diff" /dev/null
  diff "$FIX/notes.txt" "$WORK/notes.txt" || true
  printf '\nNote: the capitalised "Teh" on the rotor line survives -- matching is\ncase-sensitive. A second pass aimed at it:\n'
  show "command" /dev/null <<<'$ vim ... -c "%s/Teh/The/ge" -c "wq"'
  ( cd "$WORK" && $VIM notes.txt -c '%s/Teh/The/ge' -c 'wq' )
  show "diff after the second pass" /dev/null
  diff "$FIX/notes.txt" "$WORK/notes.txt" || true
} > "$TR/02-substitute.txt" 2>&1

# ------------------------------------------------------------ 03 delete lines
{
  hdr "03 - deleting lines by pattern and by range"
  cp "$FIX/servers.log" "$WORK/servers.log"
  show "before" "$WORK/servers.log"
  show "command" /dev/null <<<'$ vim ... servers.log -c "g/^DEBUG/d" -c "wq"'
  ( cd "$WORK" && $VIM servers.log -c 'g/^DEBUG/d' -c 'wq' )
  show "after :g/^DEBUG/d" "$WORK/servers.log"
  show "command" /dev/null <<<'$ vim ... servers.log -c "g/^$/d" -c "wq"'
  ( cd "$WORK" && $VIM servers.log -c 'g/^$/d' -c 'wq' )
  show "after :g/^$/d (blank lines gone too)" "$WORK/servers.log"
  show "total diff" /dev/null
  diff "$FIX/servers.log" "$WORK/servers.log" || true
  cp "$FIX/servers.log" "$WORK/range.log"
  show "command (fresh copy)" /dev/null <<<'$ vim ... range.log -c "3,4d" -c "wq"'
  ( cd "$WORK" && $VIM range.log -c '3,4d' -c 'wq' )
  show "after :3,4d" "$WORK/range.log"
} > "$TR/03-delete-lines.txt" 2>&1

# ------------------------------------------------------------ 04 text objects
{
  hdr "04 - operator + motion, and text objects"
  cp "$FIX/sentence.txt" "$WORK/op1.txt"
  show "command" /dev/null <<<'keys typed: gg0 dw   (go to start, delete word)'
  ( cd "$WORK" && $VIM op1.txt -c 'execute "normal! gg0dw"' -c 'wq' )
  show "after dw on line 1" "$WORK/op1.txt"
  show "diff" /dev/null; diff "$FIX/sentence.txt" "$WORK/op1.txt" || true

  cp "$FIX/sentence.txt" "$WORK/op2.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: gg0 ciw Slow <Esc>   (change inner word)'
  ( cd "$WORK" && $VIM op2.txt -c 'execute "normal! gg0ciwSlow\<Esc>"' -c 'wq' )
  show "after ciw" "$WORK/op2.txt"
  show "diff" /dev/null; diff "$FIX/sentence.txt" "$WORK/op2.txt" || true

  cp "$FIX/sentence.txt" "$WORK/op3.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: 2G f( ci( Thursday <Esc>   (change inside parentheses)'
  ( cd "$WORK" && $VIM op3.txt -c 'execute "normal! 2Gf(ci(Thursday\<Esc>"' -c 'wq' )
  show "after ci(" "$WORK/op3.txt"
  show "diff" /dev/null; diff "$FIX/sentence.txt" "$WORK/op3.txt" || true

  cp "$FIX/notes.txt" "$WORK/op4.txt"
  show "command (fresh copy of notes.txt)" /dev/null <<<'keys typed: 3G dap   (delete a paragraph)'
  ( cd "$WORK" && $VIM op4.txt -c 'execute "normal! 3Gdap"' -c 'wq' )
  show "after dap on the second paragraph" "$WORK/op4.txt"
  show "diff" /dev/null; diff "$FIX/notes.txt" "$WORK/op4.txt" || true
} > "$TR/04-text-objects.txt" 2>&1

# ------------------------------------------------------------------ 05 macro
# A macro has to be *recorded*, and recording only happens when keys are
# really typed. So this demo runs vim interactively on a pty (script(1))
# and feeds the keystrokes with vim's -s option, which interprets the
# file exactly as if the keys were typed at the keyboard.
{
  hdr "05 - recording a macro and replaying it"
  cp "$FIX/tasks.txt" "$WORK/tasks.txt"
  show "before" "$WORK/tasks.txt"
  printf 'qaI- [ ] \033jq3@a:redir! > %s\r:registers a\r:redir END\rZZ' "$WORK/reg-a.txt" > "$WORK/keys-macro.bin"
  show "keystrokes fed with vim -s (cat -v of the key file; ^[ is Esc)" /dev/null
  cat -v "$WORK/keys-macro.bin"; printf '\n'
  show "in words" /dev/null <<'EOF'
qa            start recording into register a
I- [ ] <Esc>  insert "- [ ] " at line start, back to normal mode
j             move down one line
q             stop recording        (lines 2-4 still undone)
3@a           replay the macro three times
:redir ...    capture :registers a into reg-a.txt
ZZ            save and quit
EOF
  ( cd "$WORK" && TERM=xterm script -qec "vim -Nu NONE -n -i NONE -s keys-macro.bin tasks.txt" /dev/null </dev/null >/dev/null 2>&1 )
  show "after" "$WORK/tasks.txt"
  show "diff" /dev/null; diff "$FIX/tasks.txt" "$WORK/tasks.txt" || true
  show ":registers a, captured from the same session" "$WORK/reg-a.txt"
} > "$TR/05-macro.txt" 2>&1

# ------------------------------------------------------------- 06 visual block
{
  hdr "06 - visual block mode: edit a column on many lines at once"
  cp "$FIX/block.txt" "$WORK/block1.txt"
  show "command" /dev/null <<<'keys typed: gg0 <Ctrl-V> 3j I # <Esc>   (block-insert at column 1)'
  ( cd "$WORK" && $VIM block1.txt -c 'execute "normal! gg0\<C-V>3jI# \<Esc>"' -c 'wq' )
  show "after block insert" "$WORK/block1.txt"
  show "diff" /dev/null; diff "$FIX/block.txt" "$WORK/block1.txt" || true

  cp "$FIX/block.txt" "$WORK/block2.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: gg0 <Ctrl-V> 3j $ A " # checked" <Esc>   (block-append at end of line)'
  ( cd "$WORK" && $VIM block2.txt -c 'execute "normal! gg0\<C-V>3j$A # checked\<Esc>"' -c 'wq' )
  show "after block append" "$WORK/block2.txt"
  show "diff" /dev/null; diff "$FIX/block.txt" "$WORK/block2.txt" || true
} > "$TR/06-visual-block.txt" 2>&1

# --------------------------------------------------------------- 07 undo/redo
cat > "$WORK/undo.vim" <<'EOF'
%s/teh/the/ge
call writefile(getline(1,'$'), 'state-after-edit.txt')
undo
call writefile(getline(1,'$'), 'state-after-undo.txt')
redo
call writefile(getline(1,'$'), 'state-after-redo.txt')
q!
EOF
{
  hdr "07 - undo and redo, proven on buffer states"
  cp "$FIX/notes.txt" "$WORK/undo.txt"
  show "driver script (undo.vim)" "$WORK/undo.vim"
  ( cd "$WORK" && $VIM undo.txt -S undo.vim )
  show "diff: original vs after-edit" /dev/null
  diff "$FIX/notes.txt" "$WORK/state-after-edit.txt" || true
  show "diff: original vs after-undo (empty means fully undone)" /dev/null
  diff "$FIX/notes.txt" "$WORK/state-after-undo.txt" && printf '(no differences)\n'
  show "diff: after-undo vs after-redo (the edit is back)" /dev/null
  diff "$WORK/state-after-undo.txt" "$WORK/state-after-redo.txt" || true
} > "$TR/07-undo-redo.txt" 2>&1

# --------------------------------------------------------------- 08 registers
cat > "$WORK/registers.vim" <<'EOF'
execute "normal! gg\"ayy"
execute "normal! 2Gdd"
execute "normal! G\"ap"
redir! > registers.txt
silent registers
redir END
wq
EOF
{
  hdr "08 - registers: yank to a named register, delete to the unnamed one"
  cp "$FIX/tasks.txt" "$WORK/reg.txt"
  show "before" "$WORK/reg.txt"
  show "driver script (registers.vim)" "$WORK/registers.vim"
  show "in words" /dev/null <<'EOF'
gg "a yy   yank line 1 into register a
2G dd      delete line 2 (lands in the unnamed register)
G  "a p    go to the last line, put register a after it
EOF
  ( cd "$WORK" && $VIM reg.txt -S registers.vim )
  show "after" "$WORK/reg.txt"
  show "diff" /dev/null; diff "$FIX/tasks.txt" "$WORK/reg.txt" || true
  show ":registers, captured from the same session" "$WORK/registers.txt"
} > "$TR/08-registers.txt" 2>&1

# ---------------------------------------------------------- 09 search & motion
cat > "$WORK/motion.vim" <<'EOF'
redir! > motion.txt
execute "normal! gg"
silent echo 'after gg          -> line ' . line('.')
/rotor
silent echo 'after /rotor<CR>  -> line ' . line('.') . ', col ' . col('.')
execute "normal! G"
silent echo 'after G           -> line ' . line('.')
execute "normal! 0f,"
silent echo 'after 0 f,        -> line ' . line('.') . ', col ' . col('.')
execute "normal! 3G"
silent echo 'after :3 / 3G     -> line ' . line('.')
redir END
q!
EOF
{
  hdr "09 - moving: gg, G, search, find-a-character, go-to-line"
  show "driver script (motion.vim) run on notes.txt" "$WORK/motion.vim"
  cp "$FIX/notes.txt" "$WORK/motion-target.txt"
  ( cd "$WORK" && $VIM motion-target.txt -S motion.vim )
  show "positions the cursor actually reached" "$WORK/motion.txt"
} > "$TR/09-search-and-move.txt" 2>&1

# ----------------------------------------------------------------- 10 exits
{
  hdr "10 - getting out: :q! throws changes away, ZZ keeps them"
  cp "$FIX/tasks.txt" "$WORK/exit1.txt"
  ( cd "$WORK" && $VIM exit1.txt -c 'execute "normal! gg0iCHANGED: \<Esc>"' -c 'q!' )
  show "changed the buffer, then :q! -- the file on disk afterwards" "$WORK/exit1.txt"
  show "diff vs original (empty means the edit never reached the disk)" /dev/null
  diff "$FIX/tasks.txt" "$WORK/exit1.txt" && printf '(no differences)\n'
  cp "$FIX/tasks.txt" "$WORK/exit2.txt"
  ( cd "$WORK" && $VIM exit2.txt -c 'execute "normal! gg0iCHANGED: \<Esc>"' -c 'execute "normal! ZZ"' )
  show "same change, then ZZ -- the file on disk afterwards" "$WORK/exit2.txt"
  show "diff vs original" /dev/null
  diff "$FIX/tasks.txt" "$WORK/exit2.txt" || true
} > "$TR/10-exits.txt" 2>&1

# ------------------------------------------------------- 11 the example vimrc
{
  hdr "11 - the example .vimrc: what :set reports, and what a Tab becomes"
  show "command" /dev/null <<<'$ vim -Nu examples/vimrc -n -i NONE -es -c "redir! > report" -c "silent set number? expandtab? tabstop? shiftwidth? ignorecase? smartcase? incsearch? hlsearch? undofile?" -c "redir END" -c "q!"'
  ( cd "$WORK" && vim -Nu "$LAB/examples-vimrc" -n -i NONE -es \
      -c 'redir! > vimrc-report.txt' \
      -c 'silent set number? expandtab? tabstop? shiftwidth? ignorecase? smartcase? incsearch? hlsearch? undofile?' \
      -c 'redir END' -c 'q!' )
  show ":set report with the example vimrc loaded" "$WORK/vimrc-report.txt"
  : > "$WORK/tab-with.txt"; : > "$WORK/tab-without.txt"
  ( cd "$WORK" && vim -Nu "$LAB/examples-vimrc" -n -i NONE -es tab-with.txt \
      -c 'execute "normal! i\<Tab>indented\<Esc>"' -c 'wq' )
  ( cd "$WORK" && $VIM tab-without.txt \
      -c 'execute "normal! i\<Tab>indented\<Esc>"' -c 'wq' )
  show "typed a Tab then 'indented', WITH the vimrc (expandtab on) -- cat -A" /dev/null
  cat -A "$WORK/tab-with.txt"
  show "same keystrokes with -u NONE (vim defaults) -- cat -A (^I is a real tab)" /dev/null
  cat -A "$WORK/tab-without.txt"
} > "$TR/11-vimrc-effects.txt" 2>&1

# ------------------------------------------------------ 12 buffers & windows
cat > "$WORK/windows.vim" <<'EOF'
edit notes.txt
vsplit tasks.txt
redir! > windows.txt
silent echo 'windows open: ' . winnr('$')
silent ls
execute "wincmd h"
silent echo 'after Ctrl-W h, current buffer: ' . bufname('%')
execute "wincmd l"
silent echo 'after Ctrl-W l, current buffer: ' . bufname('%')
redir END
qa!
EOF
{
  hdr "12 - buffers and split windows"
  cp "$FIX/notes.txt" "$WORK/notes.txt"; cp "$FIX/tasks.txt" "$WORK/tasks.txt"
  show "driver script (windows.vim)" "$WORK/windows.vim"
  ( cd "$WORK" && $VIM -S windows.vim )
  show "what the session reported" "$WORK/windows.txt"
} > "$TR/12-buffers-windows.txt" 2>&1

# --------------------------------- 13 word motions, inserting, visual line
# Added when the guide was finished: transcripts 01-12 had no capture of
# the word motions (w/b) or of the insert entries (I/A/o/O), and visual
# mode was only shown in its block form. All three gaps close here, the
# same way as the rest of the lab: real vim, fresh copies, states proven.
cat > "$WORK/words.vim" <<'EOF'
redir! > words.txt
execute "normal! gg0"
silent echo 'at gg0        -> line ' . line('.') . ', col ' . col('.')
execute "normal! w"
silent echo 'after w       -> line ' . line('.') . ', col ' . col('.')
execute "normal! ww"
silent echo 'after w w     -> line ' . line('.') . ', col ' . col('.')
execute "normal! b"
silent echo 'after b       -> line ' . line('.') . ', col ' . col('.')
redir END
q!
EOF
{
  hdr "13 - word motions, the insert entries, and visual-line mode"
  cp "$FIX/sentence.txt" "$WORK/words-target.txt"
  show "driver script (words.vim) run on sentence.txt" "$WORK/words.vim"
  ( cd "$WORK" && $VIM words-target.txt -S words.vim )
  show "positions the cursor actually reached (words start at col 1 The, 5 quick, 11 brown, 17 fox)" "$WORK/words.txt"
  printf '\n'

  printf 'line one\n' > "$WORK/ins.txt"
  show "insert fixture, before" "$WORK/ins.txt"
  show "command" /dev/null <<<'keys typed: A " tail" <Esc>   (A = append at end of line; a leading space is typed)'
  ( cd "$WORK" && $VIM ins.txt -c 'execute "normal! A tail\<Esc>"' -c 'wq' )
  show "after A" "$WORK/ins.txt"
  printf 'line one\n' > "$WORK/ins.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: o line two <Esc>   (o = open a new line below)'
  ( cd "$WORK" && $VIM ins.txt -c 'execute "normal! oline two\<Esc>"' -c 'wq' )
  show "after o line two" "$WORK/ins.txt"
  printf 'line one\n' > "$WORK/ins.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: I >> <Esc>   (I = insert at first non-blank of the line)'
  ( cd "$WORK" && $VIM ins.txt -c 'execute "normal! I>> \<Esc>"' -c 'wq' )
  show "after I >> " "$WORK/ins.txt"
  printf 'line one\n' > "$WORK/ins.txt"
  show "command (fresh copy)" /dev/null <<<'keys typed: O line zero <Esc>   (O = open a new line above)'
  ( cd "$WORK" && $VIM ins.txt -c 'execute "normal! Oline zero\<Esc>"' -c 'wq' )
  show "after O line zero" "$WORK/ins.txt"

  cp "$FIX/tasks.txt" "$WORK/visl.txt"
  show "visual-line fixture, before" "$WORK/visl.txt"
  show "command" /dev/null <<<'keys typed: 2G V j x   (go to line 2, visual-line, extend down, cut)'
  ( cd "$WORK" && $VIM visl.txt -c 'execute "normal! 2GVjx"' -c 'wq' )
  show "after 2G V j x" "$WORK/visl.txt"
  show "diff" /dev/null; diff "$FIX/tasks.txt" "$WORK/visl.txt" || true
} > "$TR/13-words-inserting-visual-line.txt" 2>&1

printf 'Lab complete: %s transcripts\n' "$(ls "$TR" | wc -l)"
