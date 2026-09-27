---
title: Agent-agnostic instructions
tags: [second-brain, agents, conventions]
created: 2026-09-25
---

# Agent-agnostic instructions

## The problem

Many AI agents look for their instructions in a place of their own: a
file with a specific name at the project root, a commands folder with
its own syntax. If I write the instructions there, the system belongs
to one agent. Yet the instructions are the most valuable part of working
with an agent, because they accumulate everything I have learned about
making it work well, so they belong to the
[core](core-and-adapters.md).

## Two levels

- **`AGENTS.md`**, at the root: what the agent must *always* know, in
  every session. Context and rules.
- **`workflows/`**: what the agent must do *when I ask*. One procedure
  per file.

`AGENTS.md` is short because it is read every time; workflows can be
detailed because they are read only when needed.

## AGENTS.md

It contains, in this order:

1. **Purpose**: two lines on what the archive is and who it is for.
2. **Structure**: the folders and what each one is for.
3. **Format**: an operational summary of the rules, pointing to
   `notes/note-format.md` as the full reference.
4. **Hard rules**: what the agent never does (see below).
5. **Available workflows**: the files in `workflows/`, one line each.

It does not explain the reasons behind the choices: those live in the
notes, where I read them. `AGENTS.md` is written for whoever executes,
the notes for whoever understands.

## Hard rules

The minimal set, to be included in `AGENTS.md`:

- Never delete notes: move them to `archive/`.
- Never link to notes that do not exist.
- Never edit files outside the archive.
- Never copy non-text files into the archive: their content goes into
  notes, the originals stay outside.
- Never edit the adapters unless explicitly asked.
- Never commit: leave the changes to be reviewed with `git diff`.
- When in doubt about where a note goes or what to call it, ask instead
  of deciding.

## workflows/

Each file describes a procedure in imperative prose, with the same
structure:

```markdown
# Triage

## Purpose
Empty inbox/ by giving every capture a destination.

## Input
Every file in inbox/.

## Steps
1. For every file, work out what it is about.
2. If a note on the same topic already exists, integrate the content
   there; otherwise create a new note in the expected format.
3. Look for related notes and add links in both directions.
4. Move the original file to archive/inbox/.

## Output
A summary: for every capture, where it went and which links were added.

## Constraints
No new note for one-line captures with no context: ask.
```

Two rules for writing them:

- **No agent syntax.** Arguments are named in prose ("the user's
  question"), not with placeholders specific to a tool; the adapter
  passes them.
- **Runnable by hand.** A workflow must be clear enough for me to follow
  it without an agent. If I cannot, it is badly written for the agent
  too.

## Adapters for an agent

A new agent needs at most two things.

**The startup file.** If the agent reads `AGENTS.md` on its own, nothing
is needed. Otherwise, a file with the name it expects, which imports
`AGENTS.md` if the agent supports imports, or contains a single
sentence: "Read `AGENTS.md` and follow its instructions."

**The commands.** One per workflow, one line each, pointing to the file
and passing any arguments with the agent's syntax, for example: "Run
`workflows/ask.md`. Question: $ARGUMENTS". Commands are a convenience:
without them, I just ask the agent to run the workflow by name.

## Test

I open a session with an agent other than the usual one, or without
adapters, and ask it to run a workflow after reading only `AGENTS.md`.
If the result is comparable, the instructions really are agnostic.

## Why

**Prose instead of configuration.** Prose is the only interface every
agent understands, and will keep understanding. Any specific structured
format is a bet on the lifespan of a tool.

**Workflows runnable by hand.** The system degrades gracefully: without
an agent it gets slower, not unusable.

**Separating what is known from what is done.** A single file with
context and procedures grows until the agent stops reading it
carefully. Two levels keep short what is read every time.

**No commits by the agent.** Reviewing the diff is when I notice
mistakes and update the instructions; skipping it means losing the
mechanism by which the system improves.

## Links

- [Second brain](../areas/second-brain.md)
- [Core and adapters](core-and-adapters.md)
- [Note format](note-format.md)
