# Distill

## Purpose

Bring into the notes what saved answers add to them (connections
between notes, clearer explanations, worked examples) without
duplicating what the notes already say.

## Input

The saved answers named by the user, as files in `answers/`. If none
are named, every file in `answers/`.

## Steps

1. Read every answer in full, together with the notes it cites.
2. Split the content of each answer into three kinds:
   - **Restated**: what the cited notes already say, or what the answer
     takes from another saved answer (it is distilled with that one).
     Discard it.
   - **Reworked**: what the answer builds from the notes without being
     in any of them: a connection between notes, a clearer explanation,
     a worked example, a summary across several notes. These are the
     candidates.
   - **General knowledge**: the part marked as such, which did not come
     from the notes. A candidate only if the user confirms it.
3. For every candidate, pick a destination as in triage: integrate it
   into an existing note (usually one of those the answer cites), create
   a new note, or ask. A connection between two notes becomes a link in
   both directions, with a sentence explaining it if the link alone is
   not enough.
4. Present the proposals and wait for confirmation.
5. Apply only the confirmed proposals, in the note format, and update
   `updated` in every note you change. Content reworked from notes adds
   no `source` entry; confirmed general knowledge adds one only if the
   answer names its source.
6. Move every distilled answer to `archive/answers/` (create the folder
   if missing), keeping its name, so that it is no longer used as a
   source. An answer with nothing to distill is moved too. An answer
   whose proposals the user wants to postpone stays in `answers/`.

## Output

Before confirmation, for every answer: the candidates, each with its
kind (reworked or general knowledge), the destination note and one
line on what it adds; or "nothing new" if there are none.

After confirmation, the list of changes made and of answers moved.

## Constraints

- Do not copy an answer into a note: take only what the notes lack,
  rephrased to fit the destination note.
- Notes never link to `answers/` or `archive/answers/`: citations of
  saved answers are not carried over.
- Never add general knowledge without explicit confirmation.
- Do not edit the answers: only move them, once distilled.
