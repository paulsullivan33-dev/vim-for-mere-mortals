# The Small, Honest Vimrc

**Scope:** the one configuration file, a nine-line
example where every line earns its place, and the
rule that keeps other people's configs from biting
you.

Vim reads `~/.vimrc` at startup. (Every capture in
this guide was made with `-u NONE` — vim deliberately
*ignoring* any vimrc — so the lab shows you stock
behaviour, and this chapter shows you what a vimrc
changes.) The example ships as `examples/vimrc`:

```vim
" A small, honest vimrc. Every line earns its place; if a line's
" effect ever surprises you, delete the line, not the file.

set number              " show line numbers -- knowing where you are helps
set expandtab           " the Tab key inserts spaces, not a tab character
set tabstop=4           " a tab character in a file displays 4 columns wide
set shiftwidth=4        " one indent step (>> and friends) is 4 columns
set ignorecase          " searching ignores case...
set smartcase           " ...unless the pattern contains a capital letter
set incsearch           " search as you type, not after you press Enter
set hlsearch            " highlight the matches so you can see them
set undofile            " remember undo history after the file is closed

syntax on               " colour text by file type
filetype plugin indent on
```

## Proven effects

The lab loaded this vimrc and asked vim to report
itself with `:set`:

```
  number
  expandtab
  tabstop=4
  shiftwidth=4
  ignorecase
  smartcase
  incsearch
  hlsearch
  undofile
```

All nine settings in force. Then it typed the same
keystrokes — a Tab, then the word "indented" — under
this vimrc and under `-u NONE`, showing the bytes
with `cat -A`:

```
typed a Tab then 'indented', WITH the vimrc (expandtab on):
    indented$
same keystrokes with -u NONE (vim defaults):
^Iindented$
```

(`cat -A` shows a tab as `^I` and each line end as
`$`.) One setting changed what physically landed in
the file: four spaces instead of a tab character.
That is what a vimrc *is* — not theme decoration, a
set of behavioural facts like this one, including
one this chapter has already warned you about:
`ignorecase` + `smartcase` change what searches
match, which is why a borrowed config can make the
search-and-replace chapter's case lesson stop being
true on your machine.

## The borrowed-config warning

The internet is full of vimrcs, some hundreds of
lines long, offered as a rite of passage. Resist the
wholesale copy. A vimrc you don't understand changes
what keys mean, what searches match, and what bytes
your Tab key writes — invisibly, in every file,
forever after. The header comment of the example is
the whole policy: **every line earns its place; if
a line's effect ever surprises you, delete the line,
not the file.** Grow your vimrc one understood line
at a time, and it will stay a tool instead of
becoming a haunted house.

`undofile` deserves its sentence: it makes undo
history persist in a side file next to the edited
file (the lab's working directory gained a
`.tab-with.txt.un~` this way), so reopening a file
doesn't erase your ability to undo yesterday's
edit. Useful, and the reason stray `.un~` files
appear next to edited files — vim working as
configured, not littering by accident.

Check: start vim with the example — `vim -u
examples/vimrc somefile` — type a Tab in insert mode
and save; `cat -A` the file and you should see
spaces, not `^I`. Then `:set expandtab?` — vim
answers with the setting's state, the same check the
lab's report used.
