# Buffers and Windows

**Scope:** keeping several files open at once, and
splitting the screen between them. Brief on purpose —
you don't need much of this to survive, and a little
goes a long way.

## Two words, two things

- A **buffer** is a file loaded into memory. Opening
  a file makes a buffer; the file can be open
  without being on screen.
- A **window** is a view onto a buffer. Split the
  screen and you have two windows; both can even
  show the same buffer.

The commands that matter:

- `:e file` — edit another file (a new buffer)
- `:ls` — list the buffers you have open
- `:bn` / `:bp` — next / previous buffer
- `:split` / `:vsplit` — split the window,
  side-by-side for `vsplit` (optionally with a file
  name, `:vsplit file`)
- `Ctrl-W h/j/k/l` — move between windows in that
  direction; `Ctrl-W w` cycles
- `:q` in a window closes that window, not the
  session; `:qa` quits everything

## What the lab session reported

A script opened `notes.txt`, split vertically into
`tasks.txt`, and reported on itself:

```
windows open: 2
  1 #a   "notes.txt"                    line 0
  2 %a   "tasks.txt"                    line 4
after Ctrl-W h, current buffer: tasks.txt
after Ctrl-W l, current buffer: notes.txt
```

Read it plainly: two windows were open, and `:ls`
listed two buffers, with `%` marking the current one
(`tasks.txt`, the file the split had just opened —
a `vsplit` puts the new window on the left and moves
you into it) and `#` the one you'd come from. The
`Ctrl-W h` report still names `tasks.txt` — it was
already the left-hand window, so there was nowhere
further left to go — and `Ctrl-W l` then moved right
into `notes.txt`. That is the entire mental model:
windows are places on the screen, `Ctrl-W` plus a
direction walks between them, and `:ls` tells you
what's open when you've forgotten.

What this brief chapter doesn't do: tab pages
(`:tabnew` and friends — a third layer, ignored by
most mortals without loss), and arranging window
layouts beyond a single split. When a task genuinely
needs many panes at once, a terminal multiplexer is
usually the better tool, and the editing inside each
pane is everything you've already learned here.

Check: `vim` any file, then `:vsplit` a second one.
`:ls` should list both. `Ctrl-W l` and `Ctrl-W h`
walk you right and left; notice which buffer each
window reports at the bottom of the screen.
