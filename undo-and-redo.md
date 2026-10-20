# Undo and Redo

**Scope:** `u` and `Ctrl-R` — what they do, what was
proven, and the one behaviour that surprises people
the first time.

## The two keys

In Normal mode:

- `u` — undo the last change
- `Ctrl-R` — redo: put back what `u` took away

Press `u` repeatedly to walk further back; vim keeps
a long history, not a single step. Each *change* is
one step — a typed sentence is one step, not one step
per letter.

## Proven on buffer states

The lab didn't just press the keys and wave; it
wrote the buffer out at each stage of a real edit
(a `:%s/teh/the/ge` over `notes.txt`) and diffed the
stages:

- **after the edit** vs original: the three `teh`
  lines differ, as the substitute chapter shows.
- **after `undo`** vs original:

  ```
  --- diff: original vs after-undo (empty means fully undone) ---
  (no differences)
  ```

  The buffer is byte-for-byte the file you started
  with. Undo here is total, not approximate.
- **after `redo`**: the diff against the undone
  state shows the same three lines changing back —
  the edit returned, intact.

So the safe rhythm while learning is: try an edit;
if the screen looks wrong, `u` before anything
else. Nothing is final until you write the file,
and even then the session's undo history survives
until you quit — longer, with `undofile`, as the
vimrc chapter shows.

## The surprise: undo forks

Undo is a *tree*, not a line. If you undo twice,
then make a new edit, the two undone changes are
**not** redone by `Ctrl-R` anymore — you've taken a
new branch, and redo follows the branch you're on.
The old branch still exists inside vim (power users
visit it with `g-` and `g+`, named here, not taught),
but nothing in the plain `u`/`Ctrl-R` pair will
reach it. This only bites when you undo, edit,
*then* change your mind — rare, and worth knowing
before it happens rather than after.

Check: open a scratch file, make two separate
edits, press `u` once — the second edit goes, the
first stays. `Ctrl-R` — it comes back. Two `u`
presses — both gone. That walk, in your fingers,
is the whole chapter.
