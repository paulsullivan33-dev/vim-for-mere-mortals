# Glossary

**Buffer** — a file loaded into memory. A file can
be open as a buffer without being on screen.

**Command-line mode** — the one-line prompt opened
by `:` in Normal mode, where whole instructions
(`:wq`, `:%s/...`) are typed and run with Enter.

**Ex command** — a command-line-mode instruction,
named for vim's ancestor editor *ex*. The substitute
and `:g` commands are ex commands.

**Insert mode** — the mode where keys type text
into the file. Entered with `i`, `a`, `I`, `A`,
`o`, `O`, or a change operator; left with `Esc`.

**Macro** — keystrokes recorded into a register
(`qa` … `q`) and replayed as commands (`@a`). A
macro is a register whose text happens to be keys.

**Mode** — which of the keyboard's jobs is active:
Normal, Insert, Visual, or Command-line.

**Motion** — a movement command: `w`, `$`, `G`,
`f,`, and friends. Motions also serve as the
targets of operators.

**Normal mode** — the default mode, where keys are
commands. `Esc` returns here from anywhere.

**Operator** — a command that acts on a motion or
text object: `d` (delete), `c` (change), `y` (yank).

**Put** — vim's word for paste: `p` puts the
unnamed register's content; `"ap` puts register a's.

**Range** — the lines an ex command acts on: `%`
is the whole file, `3,4` is lines 3 to 4, and a
plain `s` with no range means the current line.

**Register** — a named text store. `""` is the
unnamed register every delete and yank fills; `"a`
to `"z` are chosen by you; `"1`–`"9` hold deleted
lines; `"%` holds the current file's name.

**Text object** — a structural target: `iw` inner
word, `i(` inside parentheses, `ip` inner paragraph.
The `i` prefix takes the contents; `a` takes the
contents plus their fences.

**Undo tree** — vim's history model: undo makes a
path, a new edit after undoing starts a new branch
of it.

**vimrc** — the startup file `~/.vimrc`, whose
`set` lines fix vim's behaviour for every session.

**Visual mode** — selection mode: `v` by character,
`V` by line, `Ctrl-V` by block. Motions extend the
selection; an operator acts on it.

**Window** — a view onto a buffer. Split the screen
and there are several windows; `:ls` lists buffers,
not windows.

**Yank** — copy: `y` with a motion, `yy` for the
line. Yanking fills a register without deleting.
