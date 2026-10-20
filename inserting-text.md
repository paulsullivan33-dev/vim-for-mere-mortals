# Inserting Text

**Scope:** the six doors into Insert mode, what each
one does to the line you're on, and the one key
that closes them all.

You enter Insert mode when you mean to type. Vim
gives you a door at every position you might want to
start:

| Keys | Enters insert mode… |
|---|---|
| `i` | before the cursor |
| `a` | after the cursor ("append") |
| `I` | at the line's first non-blank character |
| `A` | at the end of the line |
| `o` | on a new line opened below |
| `O` | on a new line opened above |

Every door closes the same way: **`Esc`** returns to
Normal mode. Type, `Esc`, look at what you did, move
on — that rhythm is most of editing.

## Four doors, proven

The lab typed through a one-line fixture,
`line one`, one door at a time:

**`A`** — jumped to the end of the line and typed
` tail`:

```
line one tail
```

**`o`** — opened a line below and typed on it:

```
line one
line two
```

**`I`** — went to the first non-blank and typed
`>> `:

```
>> line one
```

**`O`** — opened a line above and typed on it:

```
line zero
line one
```

Notice what the capitals do: `I`/`A` are `i`/`a`
with the travelling done for you (start of text, end
of line), and `O` is `o` mirrored. Learn the four in
that table's lower half and the top two fill in by
symmetry.

Two habits worth forming early. First, keep insert
trips short: type the thing, `Esc`, check — long
insert sessions are where "my keys are typing
commands into the file" accidents are born, because
the reverse accident (commands typed as text) is
what wandering insert mode produces. Second, when
an edit is "replace this word", don't reach for the
insert doors at all — `ciw` from the grammar chapter
deletes the word *and* opens the door in one motion.

Check: on a scratch file with a few lines, stand on
the middle line and try each door in turn, `Esc`
between them, `u` to undo each. The four results
should match the lab's exactly.
