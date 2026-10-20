# Search and Replace

**Scope:** the `:` commands that work on the whole
file at once — substitute, delete-by-pattern, delete
by range — and an honest look at case sensitivity.

These are command-line mode: press `:` in Normal
mode, type the command, press Enter.

## The substitute: `:%s/teh/the/ge`

Anatomy, using the lab's actual command:

- `%` — the *range*: the whole file. (Other ranges
  exist — `3,4` is lines 3 to 4, as you'll see.)
- `s/teh/the/` — substitute: find `teh`, write `the`.
- `g` — *global*: every match on a line, not just
  the first.
- `e` — no error if there are no matches; the
  command stays quiet instead of complaining. Worth
  adding whenever a script or a tired human might
  run it on a file that's already fixed.

Run on `notes.txt`, which is riddled with `teh`:

```
--- before ---
teh server in teh closet runs teh backup job.
Nobody remembers why teh schedule is 3 AM.
--- after :%s/teh/the/ge ---
the server in the closet runs the backup job.
Nobody remembers why the schedule is 3 AM.
```

One command, six fixes across three lines, and the
`g` flag is the difference between that and fixing
only the first `teh` on each line.

## Case sensitivity is real

One line survived the pass untouched:

```
Teh rotor needs grease before winter comes.
```

Matching is **case-sensitive by default**: `teh`
does not match `Teh`. The lab aimed a second pass at
the capital — `:%s/Teh/The/ge` — and the diff shows
that line finally changing. Two morals: read your
diff thinking about case, and know that the vimrc
chapter's `ignorecase`/`smartcase` settings change
this behaviour — a config you didn't write can make
your searches act differently than this chapter
describes. (Options like `\c` in the pattern itself
exist too; the companion guide
*Text Processing for Mere Mortals* teaches the
pattern language — anchors, classes, grouping —
that all of this builds on.)

Add `c` to the flags — `:%s/teh/the/gce` — and vim
asks about each match before changing it: slower,
and the right choice the first time you run a
substitute on a file you can't recreate.

## Deleting lines by pattern: `:g/^DEBUG/d`

`:g/pattern/d` means "on every line matching the
pattern, run `d` (delete)". On the lab's log file:

```
--- before ---
INFO 06:00 backup started
DEBUG scanning /srv
DEBUG reading config

INFO 06:01 backup finished

DEBUG cleanup pass
INFO 06:02 mail sent
--- after :g/^DEBUG/d ---
INFO 06:00 backup started

INFO 06:01 backup finished

INFO 06:02 mail sent
```

A second pass, `:g/^$/d`, deleted the blank lines
(`^$` matches an empty line), leaving the three INFO
lines. This pair — strip the noise lines, strip the
blanks — is the single most useful log-cleaning move
in this guide.

## Deleting by range: `:3,4d`

Same idea, addressed by number instead of pattern.
On a fresh copy of the log, `:3,4d` deleted exactly
lines 3 and 4 — the second DEBUG line and the blank
after it. Ranges work in substitutes too:
`:3,4s/DEBUG/TRACE/` changes only that stretch of
the file.

Check: make a copy of any log you own. Run
`:g/^$/d` — blanks gone. Run `:%s` on a word you can
see twice on one line, once without `g` and once
with (undo, `u`, between tries) — the flag's effect
is the sort of thing you should see once with your
own eyes.
