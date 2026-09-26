# Ask

## Purpose

Answer a question using the archive as the source, so that what the
user has already written is found again instead of rebuilt from
scratch.

## Input

The user's question.

## Steps

1. Identify the key concepts of the question and their synonyms.
2. Search `notes/`, `projects/`, `areas/` and `journal/`: titles, tags
   and text. Do not search `archive/` unless the question calls for it
   or the rest is not enough.
3. Read the relevant notes in full and follow their links one level
   deep, to gather context.
4. Build the answer from what the notes say.
5. If the notes are not enough to answer, say so explicitly. You may
   add general knowledge only in a separate part, marked as such.

## Output

- The answer, citing for every claim the note it comes from, with its
  path from the archive root (`notes/poisson-process.md`).
- If any, the gaps: what is missing from the archive to answer well.
- If any, the contradictions: notes that say incompatible things.

Many chat interfaces do not render math and treat backslashes as
escapes (`\,` becomes `,`). So, in the chat answer:

- LaTeX formulas go in `latex` code blocks; short ones inline, as
  inline code;
- diagrams go in `mermaid` blocks;
- code goes in blocks tagged with the language.

If the user asks to save the answer, also write it to
`answers/YYYY-MM-DD-topic.md` (topic in kebab-case, ASCII only; create
the folder if missing), as plain Markdown: math between `$...$` and
`$$...$$`, diagrams in `mermaid` blocks, code in blocks tagged with the
language. In chat, a short summary and the file path are enough.

## Constraints

- Read-only: this workflow does not edit, create or move files. The
  only exception is the file in `answers/`, and only if the user asks
  to save the answer.
- Do not attribute to the notes what they do not say. A paraphrase must
  stay faithful; when in doubt, quote the sentence.
