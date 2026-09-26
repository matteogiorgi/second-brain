# AGENTS.md

## Purpose

A personal archive of notes, in plain text and versioned with git. It
collects, connects and retrieves ideas from study, work and projects.
Your job is to organise and query it following the rules below.

## Structure

- `inbox/`: raw captures, just taken, with no format. To be triaged.
- `notes/`: atomic notes, one idea per file, all at the same level.
  This is the default destination.
- `projects/`: notes tied to something with an end (an exam, a thesis,
  a repository).
- `areas/`: notes on ongoing responsibilities (study, career, this
  archive).
- `journal/`: daily notes, `YYYY-MM-DD.md`.
- `archive/`: retired notes, in the same subfolder they came from
  (`archive/projects/...`); `archive/inbox/` for original captures
  already triaged; `archive/answers/` for saved answers already
  distilled. To retire a note, move it keeping its subfolder, then
  update its relative links and those of the notes that cite it.
- `workflows/`: procedures to run on request.
- `answers/`: answers from the `ask` workflow, saved on request. They
  are not notes: never link them from a note, and search them only when
  a workflow says so.
- `bin/`: helper scripts (`capture`, `links`). You may run them, not
  edit them.
- `editors/`, `CLAUDE.md`, `.claude/` and other tool configuration
  files: they are not notes, do not touch them.

## Format

The full reference, if present, is `notes/note-format.md`; in short:

- File names: lowercase, kebab-case, ASCII only, `.md` extension.
- YAML frontmatter is required in every note: `title`, `tags` (a list,
  lowercase, kebab-case, ASCII), `created` (YYYY-MM-DD). Raw captures
  (`inbox/`, `archive/inbox/`) and saved answers (`answers/`,
  `archive/answers/`) are not notes and have none.
  Optional: `updated`, `source`. No other fields.
- `source`: when the content comes from a source (book, article,
  lecture, a file the user gave you), describe it so it can be found
  again: author, title, chapter, URL or lecture date. Never a file path.
- A single level-1 heading, equal to `title`; level-2 sections.
- Markdown links relative to the current file, with the extension:
  `[text](other-note.md)`, `[text](../areas/note.md)`. Never wikilinks,
  never absolute paths, no links to sections.
- Wrap lines by hand at about 72 columns.
- Fenced code blocks name their language; tables in GitHub style; math
  in LaTeX between `$...$` and `$$...$$`. No other extensions.
- End every note with a `## Links` section; when the note records a
  choice, add a `## Why` section right before it.
- Language: English.

## Hard rules

- Never delete files: move them to `archive/`.
- Never link to notes that do not exist.
- Never edit files outside this folder.
- Never copy non-text files (PDFs, images, audio) into the archive:
  their content goes into notes, the originals stay outside.
- Never edit tool configuration files unless explicitly asked.
- Never commit: leave the changes to be reviewed with `git diff`.
- Never invent content: notes report what is in the captures, what the
  user confirmed from a saved answer, or what the user asked you to
  write.
- When in doubt about where a note goes, what to call it or whether to
  merge it with another, ask instead of deciding.

## Available workflows

When asked to run a workflow, read the matching file and follow it.

- `workflows/triage.md`: turns the captures in `inbox/` into real notes.
- `workflows/ask.md`: answers a question using the notes (and, on
  request, the saved answers).
- `workflows/connect.md`: finds missing links, orphan notes and broken
  links.
- `workflows/distill.md`: brings into the notes what saved answers add
  to them.
