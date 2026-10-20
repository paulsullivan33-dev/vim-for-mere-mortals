# Visual Mode

**Scope:** selecting text by moving — by character,
by line, and by block — and the block trick that
justifies the whole chapter: editing a column on
many lines at once.

## Selecting is just moving, with the anchor down

Press `v`, `V`, or `Ctrl-V` in Normal mode and you
are selecting; every motion extends the selection,
and the next operator (`d`, `y`, `c`, `x`…) acts on
exactly what is highlighted. `Esc` cancels.

- `v` — character by character
- `V` — whole lines at a time
- `Ctrl-V` — a **block**: a rectangle, columns
  included

The line flavour, proven in the lab on `tasks.txt` —
stand on line 2, `V`, extend down with `j`, cut
with `x`:

```
write the minutes          write the minutes
file the report     →      check the repeater
water the plants
check the repeater
```

Lines 2 and 3 went together; the diff shows exactly
those two lines removed and nothing else touched.
That is the shape of most visual work: select whole
lines, then delete, yank, or indent them as a unit.

## The block trick

`Ctrl-V` selects a rectangle, and two things you can
do to a rectangle have no real equivalent in other
editors. The lab ran both on a four-line server list.

**Block insert** — select column 1 of all four
lines (`gg0`, `Ctrl-V`, `3j`), press `I`, type `# `,
`Esc`:

```
# server alpha
# server beta
# server gamma
# server delta
```

The text was typed *once*, on the first line, and
appeared on all four when `Esc` closed the insert.
Commenting out a block of config is this exact move.

**Block append** — same rectangle, extended to each
line's end with `$`, then `A` and the text:

```
server alpha # checked
server beta # checked
server gamma # checked
server delta # checked
```

The four lines have *different lengths*, and the
annotation landed at each line's own end — the `$`
in a block selection means "to the end of each
line", not "to the block's edge". Annotating,
marking, or initialling a ragged list of lines is
the everyday shape of this.

Character-wise `v` remains the precision tool — the
one for selecting half a line or a phrase mid-line.
It follows the same rule as everything here: motion
extends, operator acts. It isn't separately
demonstrated in the lab (headless captures show
states, not half-selected screens), because once
line and block selection make sense, `v` is the
same idea at finer grain.

Check: take a list of your own, at least four lines.
`Ctrl-V` down its left edge, `I`, type `x`, `Esc` —
every line should gain the mark at once. `u` undoes
the whole block edit as a single change.
