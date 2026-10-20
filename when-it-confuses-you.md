# When It Confuses You

**Scope:** symptom → fix for the classic ambushes.
Each fix points at the chapter that proved it.

**Keys type letters into the file when I expected
commands.** You are in Insert mode (chapter 1).
Press `Esc`; you are in Normal mode, where keys
command again. Undo with `u` if the typed letters
did damage.

**Keys do things — things disappear — when I just
want to type.** Same coin, other side: you are in
Normal mode and your intended text is being read as
commands. `u` undoes; then press `i` (or `a`) before
typing. The fix is never a setting; it is always
knowing which mode you're in.

**Vim won't quit; it complains about unsaved
changes.** Plain `:q` refuses by design. Decide:
`:q!` discards the changes — proven in chapter 2,
the file on disk untouched — or `ZZ` saves them,
proven the same way.

**My replace missed the capitalised word.** Matching
is case-sensitive by default: `:%s/teh/the/ge` fixed
six `teh`s and left `Teh` standing, exactly as
chapter 9 recorded. Aim a pass at the capital, or
check whether a vimrc has set `ignorecase` (`:set
ignorecase?`) — with `smartcase`, a lowercase pattern
matches both cases and this symptom vanishes.

**Paste gave me the line I just deleted, not the
one I yanked.** Every delete overwrites the unnamed
register, and plain `p` pastes the unnamed register.
Chapter 8's listing shows a delete landing in `""`
while the keeper sat safe in `"a`. Yank keepers into
a named register (`"ayy`), put them with `"ap`.

**Undo stopped redoing what I expected.** You undid,
then made a *new* edit: undo forked, and `Ctrl-R`
now follows the new branch (chapter 7). The old
branch isn't reachable from `u`/`Ctrl-R` anymore.
Save the lesson, re-make the edit by hand, move on.

**A file's indentation changed character — spaces
became tabs or tabs became spaces.** Tab behaviour
is a *setting*, not a file fact: `expandtab` on
writes spaces for the Tab key (proven byte-for-byte
in chapter 11); off, vim writes real tabs. Check
`:set expandtab? tabstop?` before blaming the file
— or a colleague's vimrc.

**The screen is a split I didn't mean to make.**
Something (`:vsplit`, a help window) opened a second
window. `:q` closes the window you're in without
quitting the session; `Ctrl-W w` cycles between
windows (chapter 10).

**Everything is fine but I want out and nothing
saved, *right now*.** `Esc`, `:q!`, Enter. Chapter 2
exists so that sentence is boring.
