# The Editing Grammar

**Scope:** the pattern underneath most vim editing —
*operator + motion* — plus text objects, the part
that makes the grammar worth learning.

## One pattern, many edits

In Normal mode, editing commands are sentences:

- an **operator** says what to do: `d` delete,
  `c` change (delete, then drop you into Insert
  mode), `y` yank (copy)
- a **motion** says where to: `w` to the next word,
  `$` to the end of the line, `G` to the end of the
  file, and everything from the moving chapter

`dw` is "delete word". `c$` is "change to end of
line". You don't memorise hundreds of commands; you
learn a handful of operators and the motions you
already know, and combine them. Doubling an operator
makes it act on the whole line: `dd` deletes the
line, `yy` yanks it.

## Proven in the lab

Four edits on fixture files, each time showing the
diff against the original:

**`dw` — delete word**, cursor at the start of
`sentence.txt`:

```
1c1
< The quick brown fox jumps over the lazy dog.
---
> quick brown fox jumps over the lazy dog.
```

**`ciw` — change inner word**, replacing "The" with
"Slow" (the `iw` part is a *text object*, below):

```
1c1
< The quick brown fox jumps over the lazy dog.
---
> Slow quick brown fox jumps over the lazy dog.
```

**`ci(` — change inside parentheses**, on line 2.
The cursor found the `(` on the line, and the change
reached *inside* it:

```
2c2
< The meeting is on (Tuesday) in the main hall.
---
> The meeting is on (Thursday) in the main hall.
```

**`dap` — delete a paragraph**, run on line 3 of
`notes.txt`. The whole paragraph went, including its
trailing blank line:

```
3,5d2
< teh server in teh closet runs teh backup job.
< Nobody remembers why teh schedule is 3 AM.
< 
```

## Text objects: motions that know structure

A text object names a *thing* instead of a
direction: `iw` inner word (the word, not the space
after it), `aw` a word (with the space), `i(`/`a(`
inside/around parentheses, `i"` inside quotes,
`ip`/`ap` inner/a paragraph. Prefix with `i` for
"just the contents" or `a` for "the contents plus
their fences" — `ci"` rewrites a quoted string
without touching the quotes; `ca"` takes the quotes
too.

This is the part of vim that repays practice first.
`ciw` works wherever the cursor sits inside the
word; you stop hunting for word boundaries, and the
operator doesn't care which object follows it —
`yap` yanks a paragraph as happily as `dap` deletes
one.

Check: in a scratch file, put the cursor anywhere
inside a word and type `ciw`, a replacement, `Esc`.
Then `u` (undo — a later chapter) and try `diw`
instead: same targeting, no typing. If both aimed
where you expected, the grammar has clicked.
