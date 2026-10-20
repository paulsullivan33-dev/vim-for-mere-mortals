# Learning More

**Scope:** the teacher built into vim itself, one
paragraph on its famous fork, and this guide's
honest limits.

## vimtutor: the teacher on the machine

Vim ships its own tutor. The lab confirmed it's
here — `command -v vimtutor` answers
`/usr/bin/vimtutor` — and showed the opening of the
tutor file it works from:

```
===============================================================================
=    W e l c o m e   t o   t h e   V I M   T u t o r    -    Version 1.7      =
===============================================================================

     Vim is a very powerful editor that has many commands, too many to
     explain in a tutor such as this.  This tutor is designed to describe
     enough of the commands that you will be able to easily use Vim as
     an all-purpose editor.
```

Run `vimtutor`, and it opens a *copy* of a lesson
file — you edit the lessons themselves as you go,
safely, because the original is never touched. It
walks the same ground as this guide (moving,
deleting, undo, search) and beyond it, in exercises
rather than prose. Working it is interactive by
nature, so it is a recommendation, not one of this
guide's captures; the honest claim is "it exists on
this machine and starts with those words", both of
which the lab verified. If this guide got you out of
trouble, the tutor is the right next hour.

Inside vim itself, `:help` opens the full manual —
huge, precise, and searchable with the same `/`
you've learned. `:help ciw` would take you straight
to the text-objects documentation.

## Neovim, in one paragraph

Neovim is a fork of vim that shares the modal
editing model almost entirely — modes, operators,
motions, text objects, registers, macros: what you
learned here transfers. The differences live around
the edges of this guide's scope (a Lua-first
configuration in `~/.config/nvim/`, different
defaults for several of the vimrc chapter's
settings, a larger built-in feature set). Neovim is
not installed on the build machine, so nothing in
this guide was run against it; treat that paragraph
as a signpost, not a finding.

## Honest limits

- Everything here is one build of vim (9.1, Debian)
  on one machine. The editing model is stable and
  decades old; paths and packaging details are not
  guaranteed to match your box.
- This is a survival and everyday-editing guide.
  Vim goes far deeper — scripting, plugins, folding,
  diff mode, sessions — and none of that is here,
  on purpose.
- A modal editor's learning curve is real even with
  the curve's worst part (the exits) handled first.
  The tutor exists because nobody absorbs this from
  a manual alone; use it.

Check: `vimtutor` — quit it with the same `Esc`,
`:q!` you now own, whenever you've had enough.
That sentence being unremarkable is the point of
the whole guide.
