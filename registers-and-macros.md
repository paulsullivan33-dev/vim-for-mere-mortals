# Registers and Macros

**Scope:** where yanked and deleted text actually
goes (registers), and recording an edit once to
replay it many times (macros) — including the
lab's most unusual capture: a macro recorded with
real keystrokes.

## Registers: more clipboards than you think

Vim doesn't have *a* clipboard. It has **registers**
— named stores, each holding text. The ones that
matter day to day:

- the **unnamed register** `""` — where every delete
  and yank lands by default
- **named registers** `"a` to `"z` — stores you
  choose, which nothing overwrites behind your back
- `"1` to `"9` — a short history of deleted *lines*
- `"%` — the current file's name

Prefix a yank, delete, or put with `"a` to aim it:
`"ayy` yanks the line into register a, `"ap` puts
register a's content. `:registers` lists what's
currently held.

## Proven: a yank, a delete, and what the registers said

The lab ran this on `tasks.txt`:

```
gg "a yy   yank line 1 into register a
2G dd      delete line 2 (lands in the unnamed register)
G  "a p    go to the last line, put register a after it
```

The file afterwards (line 2 gone, line 1 repeated at
the end):

```
write the minutes
water the plants
check the repeater
write the minutes
```

And `:registers`, captured from the same session:

```
Type Name Content
  l  ""   file the report^J
  l  "1   file the report^J
  l  "a   write the minutes^J
  c  "%   reg.txt
```

Three lessons in one listing. The deleted line —
"file the report" — went to *both* the unnamed
register and `"1`; the yank into `"a` survived
untouched, ready to put; and the everyday trap is
now visible: **a plain `p` pastes the unnamed
register, so any delete since your yank replaces
what `p` gives you.** Yank keepers into a named
register and the trap disarms.

## Macros: a register that holds keystrokes

A macro is the same idea one level up: record keys
into a register, replay them as commands.

- `qa` — start recording into register a (any
  letter works)
- do the edit, ending back in Normal mode
- `q` — stop recording
- `@a` — replay it; `3@a` replays three times;
  `@@` replays the most recent macro again

Recording only happens when keys are really typed,
so the lab drove vim on a terminal with vim's `-s`
key-file — the keystrokes exactly as fingers would
send them. The job: turn a four-line task list into
a checklist, editing the first line by hand and
letting the macro repeat the edit:

```
qa            start recording into register a
I- [ ] <Esc>  insert "- [ ] " at line start, back to normal mode
j             move down one line
q             stop recording        (lines 2-4 still undone)
3@a           replay the macro three times
```

The result:

```
- [ ] write the minutes
- [ ] file the report
- [ ] water the plants
- [ ] check the repeater
```

And the proof of what a macro *is* — `:registers a`
from that same session shows register a holding the
keystrokes themselves: `I- [ ] ^[j` — the insert
command, the text, an `Esc` (`^[`), and the move
down. A macro is not a feature bolted onto vim; it
is a register whose text happens to be commands.
That is also why `q` must be pressed in Normal mode
and why an `Esc` inside the edit matters — both
are in the recording, exactly as typed.

Check: on a scratch list of several lines, record
`qaI- <Esc>jq`, then `@a` a few times. If each line
gains the same prefix, you've recorded your first
macro — and used the two chapters' worth of ideas
(registers, modes, insert entry) in one motion.
