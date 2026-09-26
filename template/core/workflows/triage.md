# Triage

## Purpose

Empty `inbox/` by turning every raw capture into content of the archive,
in the right format and linked to the rest.

## Input

Every file in `inbox/`, except hidden files. Non-text files (PDFs,
images) too: read their content like any other capture.

## Steps

1. Read every capture before changing anything: nearby captures may be
   about the same idea and must be handled together.
2. For every capture (or group of captures on the same idea), search the
   existing notes to see whether the topic is already covered: search
   titles, tags and text, trying synonyms and related terms too.
3. Pick one of three paths:
   - **Integrate**: if a note on the same idea exists, add the new
     content there, in the right section, and update `updated`.
   - **Create**: if the idea is new, create a note in the expected
     format. Default destination `notes/`; `projects/` or `areas/` only
     if the capture is clearly about an existing project or area.
   - **Ask**: if the capture is ambiguous, too short to make sense of,
     or could go in several places, do not decide: put it in the list
     of questions.
4. Record where the content comes from, in the note's `source` list
   (see the format in `AGENTS.md`):
   - a capture may start with a line `source: <kind>, <description>`,
     for example `source: lecture, Stochastic methods, 2026-09-25`;
     turn it into an entry and do not copy the line into the note;
   - for a file the user gives you, the user says what it is;
   - a capture with no source is the user's own thought: it adds no
     entry. If a source is hinted at but its kind is unclear, ask.

   If the note now has content from more than one kind of source, end
   every paragraph or list item taken from a source with its kind in
   parentheses, marking the content that was already there too.
5. For every note created or changed, look for related notes and add
   links in both directions, in the `## Links` section or in the text
   where the reference is natural.
6. Move every triaged capture to `archive/inbox/`, keeping its name.
   Captures waiting for an answer stay in `inbox/`. A non-text file (a
   PDF, an image) does not go to `archive/inbox/`: leave it where it is
   and report it in the summary.

## Output

A summary in three parts, plus a fourth if needed:

- captures triaged: for each one, the note created or integrated;
- links added: pairs of notes;
- questions: for every capture left in `inbox/`, what is needed to
  triage it;
- non-text sources: which files the user must move out of the archive
  before the next triage, which would otherwise read them again.

## Constraints

- Report the content of the captures, rephrasing it clearly but without
  adding information that was not there.
- A one-line capture with no context does not become a new note: it is
  integrated into an existing note or ends up among the questions.
- `title` and file name describe the content, not the date or the
  origin of the capture.
