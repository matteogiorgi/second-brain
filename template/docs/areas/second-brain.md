---
title: Editor-agnostic and agent-agnostic second brain
tags: [second-brain, pkm, workflow, tools]
created: 2026-09-25
---

# Editor-agnostic and agent-agnostic second brain

## Idea

A personal archive of notes in plain text, versioned with git, that I
can read and write with any editor and have organised by any AI agent.
The files are the only source of truth; editors and agents are
interchangeable and plug into the system through thin adapters.

Correctness test: if I delete every adapter, the system must keep
working with `cat`, `grep` and `git`.

## Architecture

The system has three parts (details in
[core and adapters](../notes/core-and-adapters.md)):

- **Core**: the notes, their [format](../notes/note-format.md), the
  folder structure, the
  [agent instructions](../notes/agent-agnostic-instructions.md)
  (`AGENTS.md`) and the procedures (`workflows/`).
- **Adapters**: configuration specific to an editor (`editors/`) or to
  an agent (`CLAUDE.md`, `.claude/commands/`, etc.). They are thin,
  hold no logic and can be thrown away.
- **Capture**: a POSIX script that writes to the inbox from any
  terminal (see [shell capture](../notes/shell-capture.md)).

```
brain/
├── AGENTS.md          # instructions for any agent
├── CLAUDE.md          # adapter: imports AGENTS.md
├── inbox/             # raw captures, waiting for triage
├── notes/             # atomic notes, flat, one idea per file
├── projects/          # things with an end (exams, a thesis, a repo)
├── areas/             # ongoing responsibilities (study, career, this system)
├── journal/           # daily notes, YYYY-MM-DD.md
├── archive/           # retired notes: nothing is deleted, only moved
│   ├── inbox/         # original captures, already triaged
│   └── answers/       # saved answers, already distilled
├── workflows/         # procedures in prose, for people and agents
├── answers/           # saved answers from ask, not notes
├── bin/               # POSIX scripts: capture, links
├── editors/           # editor adapters (vim/, ...)
└── .claude/
    └── commands/      # adapter: each command points to a workflow
```

## Setup

The archive is created with `init.sh`, from the repository
<https://github.com/matteogiorgi/second-brain>, which copies the
starting files without ever overwriting existing ones:

```sh
init.sh --claude --vim --docs ~/brain
```

The core (folders, `AGENTS.md`, `workflows/`, `bin/`) is always
created; `--claude`, `--vim` and `--docs` add the Claude Code adapter,
the Vim adapter and these documentation notes. For the first archive
it appends `BRAIN` and `PATH` to `~/.profile` (see
[shell capture](../notes/shell-capture.md)); the remaining steps, such
as the first commit, are listed at the end of its output.

Without the script, the same steps are done by hand: create the
folders, copy the templates (or write `AGENTS.md`, the workflows and the
adapters), make `bin/` executable and run `git init`.

## Daily use

1. **Capture** without thinking: `capture "idea"` or a new file in
   `inbox/`. No decision on where it goes or what it is called.
2. **Triage** once a day with the `triage` workflow: the agent assigns
   frontmatter, name, destination and links.
3. **Ask** with the `ask` workflow when I need to find something: the
   agent answers from the notes and cites the files.
4. **Review** with `git diff` what the agent changed, then commit.

## Maintenance

**Weekly**: inbox to zero; skim the week's `git log`; run `connect` to
find missing links.

**Monthly**: retire notes that are no longer needed to `archive/`;
run `distill` on the saved answers; clean up tags (merge synonyms, drop
those used only once); reread `AGENTS.md` and fix the instructions the
agent misread during the month.

**When I change editor**: I write a new adapter in `editors/`. Nothing
in the core must change; if I have to touch the core, I designed it
badly.

**When I change agent**: I write its adapter, that is the file it reads
at startup (pointing to `AGENTS.md`) and its commands (pointing to the
files in `workflows/`). If the agent reads `AGENTS.md` natively,
nothing else is needed.

## Links

- [Core and adapters](../notes/core-and-adapters.md)
- [Note format](../notes/note-format.md)
- [Agent-agnostic instructions](../notes/agent-agnostic-instructions.md)
- [Shell capture](../notes/shell-capture.md)
