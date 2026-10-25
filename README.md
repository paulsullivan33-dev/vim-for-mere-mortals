# Vim for Mere Mortals

**Vim** is the editor you meet when you didn't choose
an editor. You ran `crontab -e` and a strange screen
opened. Git stopped mid-commit and asked you to type
a message in an interface that doesn't respond to
typing the way you expect. A rescue shell on a broken
machine offers you vim, or nothing.

This guide is survival-first: get out without losing
work, move around without panic, make the small edits
admin life actually asks for — fix a typo across a
whole file, delete the DEBUG lines from a log, comment
out a block of config — and understand the one idea
(modes) that makes the rest stop being mysterious.
It is not a road to becoming a vim wizard, and it
does not want to be.

Everything hands-on was run for real on **vim 9.1**
(the Debian build) in a scripted lab: vim was driven
headlessly against small fixture files, and every
operation is proven by the file before, the file
after, and the diff between them. The lab — fixtures,
the driver script `run-lab.sh`, and the example
vimrc — ships in `examples/`, so you can reproduce
every claim in this guide. Where an operation can't
be proven that way (a few exits, character-by-character
visual selection, one paragraph on Neovim), the text
says so and `criteria.md` keeps the full ledger.

It assumes you use a terminal and have opened vim at
least once — probably by accident.

## What this guide covers

- **Modes, the one idea** — why the keys sometimes
  type and sometimes command, and the one key that
  always gets you back
- **Getting out first** — `Esc`, `:q!`, `:wq`, `ZZ`,
  taught before anything else, deliberately
- **Moving around** — words, lines, the top and
  bottom of the file, find-a-character, search
- **The editing grammar** — operator + motion, and
  text objects: the pattern behind most of vim
- **Inserting text** — `i`, `a`, `I`, `A`, `o`, `O`,
  and what each one really does
- **Visual mode** — selecting by character, line, and
  block, including editing a whole column at once
- **Undo and redo** — `u` and `Ctrl-R`, proven on
  buffer states, plus what undo can't promise
- **Registers and macros** — named clipboards, and
  recording a repetitive edit once, replaying it
  many times
- **Search and replace** — `:%s`, `:g`, deleting
  lines by pattern and by range
- **Buffers and windows** — several files open, split
  screens, in brief
- **The small, honest vimrc** — nine settings that
  earn their place, and why borrowed configs bite
- **Learning more** — the built-in tutor, a paragraph
  on Neovim, and this guide's honest limits
- **When it confuses you** — symptom → fix for the
  classic beginner ambushes

## What it doesn't cover

Vimscript and writing your own commands, the plugin
ecosystem, GUI vim and the mouse, and using vim as a
full programming environment. Regular expressions
get used here but taught in depth in the companion
guide, *Text Processing for Mere Mortals* (grep, sed
& awk) — read that one for the pattern language
itself.

## How to use this guide

Read the first two chapters before you need them —
ideally now, not from inside a `crontab -e` you can't
leave. After that, chapters stand alone: dip into the
one that matches the job in front of you. Keep the
example vimrc around only if every line in it makes
sense to you; that rule is the chapter about it, in
one sentence.

---

## Part of the series

This guide is one of the [For Mere Mortals](https://paulsullivan33-dev.github.io/mere-mortals/) guides: plain-language guides to the tools programmers and makers use.

Related guides:

- [tmux for Mere Mortals](https://paulsullivan33-dev.github.io/tmux-for-mere-mortals/)
- [Linux for Mere Mortals](https://paulsullivan33-dev.github.io/linux-for-mere-mortals/)
- [Text Processing for Mere Mortals](https://paulsullivan33-dev.github.io/text-processing-for-mere-mortals/)

## License

The writing in this guide is licensed under [CC BY 4.0](https://github.com/paulsullivan33-dev/vim-for-mere-mortals/blob/main/LICENSE). Code examples and lab scripts are licensed under the [MIT License](https://github.com/paulsullivan33-dev/vim-for-mere-mortals/blob/main/LICENSE-CODE).
