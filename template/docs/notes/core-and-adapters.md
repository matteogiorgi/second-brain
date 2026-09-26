---
title: Core and adapters
tags: [second-brain, architecture, tools]
created: 2026-09-25
---

# Core and adapters

## Principle

A system that must outlive its tools is split in two: a **core** that
holds everything of value, and **adapters** that connect the core to a
specific tool. The core knows nothing about tools; adapters know
everything about the core, but hold nothing of their own.

It is the same pattern as hexagonal architecture (*ports and adapters*)
in software: the domain does not depend on the infrastructure, the
infrastructure depends on the domain.

## The core

The core holds everything that makes sense regardless of the tool used
with it:

- the notes themselves, in their [format](note-format.md);
- the folder structure;
- the agent instructions (`AGENTS.md`), see
  [agent-agnostic instructions](agent-agnostic-instructions.md);
- the procedures in `workflows/`, written in prose;
- the scripts in `bin/`, written in POSIX shell;
- the git history.

Rule of thumb: something belongs to the core if it still makes sense
after I uninstall every editor and every agent.

## Adapters

An adapter translates the core into the language of a tool. Examples:

- `CLAUDE.md`, which contains only `@AGENTS.md`;
- `.claude/commands/triage.md`, which only says to run
  `workflows/triage.md`;
- `editors/vim/`, with the settings to reload files and follow relative
  links.

A good adapter follows four rules.

1. **It is thin.** A few lines; if it grows, it is absorbing logic that
   belongs to the core.
2. **It points one way.** The adapter refers to the core, never the
   other way round. No note, workflow or script depends on a specific
   editor or agent: it may mention one as an example, not require it to
   work.
3. **It has no state of its own.** It keeps no data that is not also in
   the core: a tool's caches, indexes and databases can be rebuilt, so
   they are expendable.
4. **It is replaceable.** I can delete it and rewrite it for another
   tool in minutes.

## Where something new goes

When I add something to the system, I ask: *does it make sense without
this tool?* If so, it goes in the core, even if I wrote it with a
specific tool in mind. If not, it is an adapter, and I check that it
stays thin.

Typical case: an agent-specific feature, such as a hook that runs
something after every edit. The logic goes in a script in `bin/`; the
hook just calls the script. That way another agent, or I by hand, can
do the same thing.

## Correctness test

I mentally delete `CLAUDE.md`, `.claude/`, `editors/` and every other
adapter. Can I still capture, read, search, link and version the notes
with `cat`, `grep`, any editor and `git`? If so, the boundary is in the
right place.

## Limits

Portability has a price: some conveniences stay tied to a tool and do
not migrate. An extension's link graph, the diff view in the editor,
link autocompletion. I accept them as conveniences of the adapter, as
long as none becomes indispensable to use the system.

## Why

Tools change faster than ideas, and AI agents in particular change
every few months. Plain text and git last for decades. Separating core
and adapters means that what I have built up (notes, conventions,
procedures) is never held hostage by the tool of the moment, and that
trying a new tool costs an adapter, not a migration.

## Links

- [Second brain](../areas/second-brain.md)
- [Note format](note-format.md)
- [Agent-agnostic instructions](agent-agnostic-instructions.md)
