# Writing Criteria

Every guide in this repo is written to the same standard. If you're
adding or editing a guide — human or AI — hold it to these.

1. **Plain words, real ideas.** Simple language, never dumbed-down
   concepts. Explain jargon on first use; collect terms in the
   glossary.
2. **No hype.** No marketing adjectives, no "revolutionary," no
   promises about what something will do for the reader.
3. **Honest about limits.** Say what the thing *can't* do. State
   uncertainty instead of smoothing it over. Validation notes include
   what remains unverified.
4. **No invented numbers.** Benchmarks, defaults, and specs are either
   measured or qualified with "depends on your setup." If it wasn't
   tested, say so.
5. **Checkable.** Commands are meant to be run, with "Check:" blocks
   showing what success looks like. Sources are linked, not asserted.
6. **Respect the reader's setup.** Call out Windows/Mac/Linux
   differences. Don't assume a GPU, a budget, or prior experience.
7. **Safety isn't skipped.** Real risks get stated plainly, not buried.
8. **Scoped.** Each guide says what it covers and points elsewhere for
   the rest. No guide pretends to be the whole subject.
9. **Structure over prose.** Tables, before/after examples,
   symptom → fix. Scannable beats essay.

---

## Verification notes for this guide

Everything hands-on was run on the build machine:
vim 9.1 (Debian package 2:9.1.0016-1ubuntu7.20),
driven headlessly as `vim -Nu NONE -n -i NONE -es`
against small fixture files, with every operation
proven by the file before, the file after, and the
diff between them. One demo — the macro — cannot be
scripted that way, because recording requires real
keystrokes; it was run on a terminal (via `script`)
with vim's `-s` key-file feeding the keys exactly as
typed. The lab (fixtures, driver `run-lab.sh`, the
example vimrc) ships in `examples/` and its 13
transcripts are kept with the lab; re-running the
driver reproduces every transcript byte-for-byte.

**Run for real, captured:**

- `vim --version`; `command -v vim vimtutor`; the
  first 8 lines of the vimtutor lesson file (01).
- `:%s/teh/the/ge` over a fixture: six matches fixed
  across three lines; the capitalised `Teh` on
  another line survived (matching is case-sensitive),
  and a second pass `:%s/Teh/The/ge` fixed it (02).
- `:g/^DEBUG/d` and `:g/^$/d` on a log fixture;
  `:3,4d` on a fresh copy (03).
- Operator + motion and text objects, each diffed:
  `dw`, `ciw`, `ci(` (after `2G f(`), `dap` (04).
- A macro recorded with real keystrokes
  (`qa I- [ ] <Esc> j q`), replayed with `3@a`;
  `:registers a` captured from the same session,
  showing register a holding the keystrokes
  `I- [ ] ^[j` (05).
- Visual block: `Ctrl-V` over 4 lines, `I # <Esc>`
  block-insert; and with `$`, `A " # checked" <Esc>`
  block-append at each line's own end (06).
- Undo/redo proven on buffer states: after a
  substitute, `undo` restored a buffer byte-identical
  to the original; `redo` re-applied the edit (07).
- Registers: `"ayy`, `dd`, `"ap`; `:registers`
  captured showing the deleted line in `""` and `"1`,
  the yank in `"a`, the filename in `"%` (08).
- Cursor positions reported by vim itself: `gg` → 1,
  `/rotor` → line 7, `G` → line 9, `0f,` → col 20,
  `3G` → line 3; and word motions: `gg0` → col 1,
  `w` → col 5, `w w` → col 17, `b` → col 11
  (09, 13).
- Exits: an edit discarded with `:q!` never reached
  the disk (diff empty); the same edit kept with
  `ZZ` did (10).
- The example vimrc's effects: a `:set` report
  showing all nine options in force, and a typed Tab
  becoming four spaces under the vimrc vs a real tab
  (`^I` in `cat -A`) under `-u NONE` (11).
- Buffers/windows: `:ls` over two buffers after a
  `:vsplit`, window count 2, and `Ctrl-W h` /
  `Ctrl-W l` reports of the current buffer (12).
- Insert entries on a one-line fixture: `A` appends
  at end of line, `o` opens a line below, `I`
  inserts at first non-blank, `O` opens a line
  above; and visual-line `2G V j x` deleting exactly
  lines 2–3 (13).

**Documented, not run:**

- The search row of the motion report reads the
  cursor column as 1 in batch mode; the chapter says
  so, and the claim that a terminal cursor lands on
  the match itself is stock vim behaviour, described
  rather than captured.
- Plain `:q`, `:wq`, and `:x` exits. Chapter 2's
  table includes them; only `:q!` and `ZZ` were
  proven on disk states.
- `i`/`a` insert entries in isolation (the lab's
  `A`, `o`, `I`, `O` and the `ciw` change establish
  insert entry in fact; the `i`/`a` distinction is
  described).
- Character-wise visual selection (`v`) editing —
  described from the line and block captures; a
  headless state capture cannot show a
  half-selected screen.
- Undo branching behaviour (`g-`/`g+`) — named in
  the undo chapter, not exercised; the fork it
  describes is documented vim behaviour.
- `:bn`/`:bp` buffer cycling, `Ctrl-W w`, and tab
  pages — named in the buffers chapter, not run.
- vimtutor worked end-to-end (it is interactive;
  its presence and opening text were captured).
- Neovim — not installed on the build machine; one
  signpost paragraph, nothing claimed from running
  it.
- GUI vim, mouse use, vimscript, and plugins — out
  of scope entirely, and labelled so in the guide.
