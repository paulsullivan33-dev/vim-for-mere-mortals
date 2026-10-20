# Moving Around

**Scope:** getting the cursor where you want it —
by line, by word, by search, by finding a character
on the line. All in Normal mode.

## The map

| Keys | Goes to |
|---|---|
| `gg` | first line |
| `G` | last line |
| `3G` or `:3` | line 3 (any number works) |
| `w` / `b` | start of next / previous word |
| `e` | end of the word |
| `/word` Enter | the next line containing `word` |
| `n` / `N` | next / previous match of that search |
| `f,` | the next `,` *on this line* (any character) |
| `0` / `$` | start / end of the line |
| `h` `j` `k` `l` | left, down, up, right |

Counts multiply: `3j` is three lines down, `2w` two
words forward. You have already seen counts at work
in this guide's labs (`3@a`, `3j`) — they belong to
the motions too.

## Proven positions

The lab parked the cursor on fixture lines and made
vim report where it actually was. On `notes.txt`:

```
after gg          -> line 1
after /rotor<CR>  -> line 7, col 1
after G           -> line 9
after 0 f,        -> line 9, col 20
after :3 / 3G     -> line 3
```

Line 7 is the rotor line; line 9, the last, is the
shopping list, and `f,` walked its commas to column
20 — the comma after "wire". One honesty note about
the search row: the lab drives vim in batch mode,
where the reported column after a search reads 1; at
a real terminal your cursor lands on the match
itself. The line is the part the lab proves, and for
finding things, the line is what matters.

And on the first line of `sentence.txt`, word by
word (the words start at columns 1, 5, 11, 17):

```
at gg0        -> line 1, col 1
after w       -> line 1, col 5
after w w     -> line 1, col 17
after b       -> line 1, col 11
```

`w` hops to the *start* of each next word — two
presses crossed "quick" and "brown" to land on
"fox" — and `b` steps back one word-start. Between
`w`/`b` for hopping and `/` for hunting, most files
are navigable in seconds.

## The arrow-key question

The arrow keys work in vim, and so does the mouse in
many builds. `h j k l` are still worth learning,
for two unglamorous reasons: they sit under your
right hand without a reach, and they work in the
bare rescue environments where this guide's survival
framing matters. Nothing bad happens if you use the
arrows while learning; just know the letters are
there, and that `j`/`k` pair with everything else
in this guide (counts, operators, visual mode).

Check: open a file of your own. `G` to the bottom,
`gg` back. `/` a word you can see, Enter, then `n`
twice. `0` then `f.` — did you land on the first
full stop? If the cursor answers where the table
says, moving is yours.
