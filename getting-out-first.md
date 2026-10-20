# Getting Out First

**Scope:** leaving vim — keeping the changes or
throwing them away, on purpose. This is chapter two
on purpose: learn the exits before the furniture.

Every exit starts the same way: press `Esc` to be
sure you're in Normal mode. Then:

| Keys | Meaning | Saves? |
|---|---|---|
| `:q` | quit | only if nothing changed |
| `:q!` | quit, **discard everything** | no |
| `:wq` | write the file, then quit | yes |
| `ZZ` | write **if changed**, then quit | yes |
| `:x` | like `ZZ` | yes |

(`:q`, `:q!`, and `:wq` are typed on the command
line — `:` opens it, Enter runs it. `ZZ` is just two
capital Z's in Normal mode: hold Shift, tap Z twice.)

## The two that were proven in the lab

The lab edited a buffer, then left two different
ways and inspected the file on disk afterwards
(`examples/tasks.txt` was the fixture):

**Discard — change something, then `:q!`:**

```
--- changed the buffer, then :q! -- the file on disk afterwards ---
write the minutes
file the report
water the plants
check the repeater
--- diff vs original (empty means the edit never reached the disk) ---
(no differences)
```

The edit existed only in memory. `:q!` is the
emergency exit: it never asks, never saves, and the
file on disk is exactly what it was. The `!` is the
"and I mean it" mark — plain `:q` refuses to quit
over unsaved changes; `:q!` overrides.

**Keep — same change, then `ZZ`:**

```
--- same change, then ZZ -- the file on disk afterwards ---
CHANGED: write the minutes
file the report
water the plants
check the repeater
```

`ZZ` wrote the change and left in two keystrokes,
no command line involved. If nothing had changed,
it would simply have quit.

## Which one do you actually use?

- Opened vim by accident (inside `crontab -e`, a git
  prompt, a pager)? `Esc`, then `:q!`. Nothing you
  did reaches the disk.
- Made an edit you want? `ZZ`.
- Made an edit and want to *see* yourself save it?
  `:wq` — same result, spelled out.

One caution about `:q!`: "discard" means *all*
changes since the last save, not just the last one.
There is no selective undo on the way out — that's
what the undo chapter is for, *before* you leave.

Check: copy any small file, open the copy in vim,
change a word, `Esc`, `ZZ`. Reopen it — the change
is there. Change it again, `Esc`, `:q!` — reopen,
and it's gone. Two minutes, and the exits are yours
for every future ambush.
