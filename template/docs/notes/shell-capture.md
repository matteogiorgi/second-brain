---
title: Shell capture
tags: [second-brain, capture, shell, posix]
created: 2026-09-25
---

# Shell capture

## Principle

Capture is where an idea enters the system, and it must cost as little
as possible: no decisions and no dependencies. No title, no tags, no
folder to choose. Everything that requires thought is left to triage
(see [agent-agnostic instructions](agent-agnostic-instructions.md)).

For the same reason, capture depends on no editor and no agent: it
must work even when both are broken, missing or slow to start. It is
the simplest piece of the [core](core-and-adapters.md), and it must
stay that way.

## The inbox as an interface

The only contract is this: *a text file that appears in `inbox/` is a
capture*. The `bin/capture` script is just the most convenient way to
honour it. Any other way of dropping a file into `inbox/` (a sync from
the phone, a saved email, a file copied by hand) is a valid capture.

Files in `inbox/` are exempt from the [format](note-format.md): no
frontmatter, timestamped names. They become real notes only after
triage. A capture may start with a line naming its source, such as
`source: lecture, Stochastic methods, 2026-09-25`: triage turns it into
the note's `source` (see the [format](note-format.md)); without it, the
capture counts as my own thought.

## The script

`bin/capture`, in POSIX shell, has three modes, chosen by what it
receives:

- **Arguments**: the text on the command line, for one-line ideas.
- **Standard input**: the output of another command, to capture
  something that is already text.
- **Neither**: if standard input is a terminal, it opens the editor on
  a new file, for longer captures. The editor is `$EDITOR`, so the
  choice stays outside the script.

In every mode, `-s "<kind>, <description>"` writes the `source:` line
for me, and rejects a kind that is not in the [format](note-format.md).

The file name combines date, time and PID, so two captures in the same
second never overwrite each other. An empty capture (editor closed
without saving, empty pipe, blank text) leaves no file.

The archive is the one you are in (the current directory or one of its
parents); outside an archive, the one containing the script; if the
script is not inside an archive, the one in `$BRAIN`. So, with several
archives, `capture` run inside one of them writes there. If no archive
is found, the script stops with an error instead of creating an inbox
in the wrong place.

## Installation

`init.sh` appends these lines to `~/.profile`; by hand, they go in the
shell's login profile:

```sh
export BRAIN="$HOME/brain"
PATH="$BRAIN/bin:$PATH"
```

The profile is read at login; for the current shell, `. ~/.profile` is
enough. If the archive was not created with `init.sh`, the script must
also be made executable:

```sh
chmod +x "$BRAIN/bin/capture"
```

## Examples

```sh
capture "review the proof of the strong Markov property"
capture -s "lecture, Stochastic methods, 2026-09-25" "rate = mean events per unit time"
xclip -o -selection clipboard | capture # the X clipboard
man 1 sh | col -b | capture             # a whole man page
```

From an editor, just send the text to the script. In Vim, for example,
`:'<,'>w !capture` captures the visual selection. It is an example of
an adapter: convenient, but the script knows nothing about it.

## Why

**No decisions at capture time.** Every decision asked at the wrong
moment is a chance to postpone, and a postponed idea is usually lost.
Organising is a different job, done better with a fresh mind and in
bulk.

**POSIX shell.** It works on any Unix-like system without installing
anything, and it will still work in ten years.

**A contract instead of a tool.** Defining capture as "a file in
`inbox/`" means I can add new entry points without touching the rest of
the system.

## Links

- [Second brain](../areas/second-brain.md)
- [Core and adapters](core-and-adapters.md)
- [Note format](note-format.md)
- [Agent-agnostic instructions](agent-agnostic-instructions.md)
