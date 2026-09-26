# Ask

## Purpose

Answer a question using the archive as the source, so that what the
user has already written is found again instead of rebuilt from
scratch.

## Input

The user's question and, optionally:

- a restriction to a kind of source ("according to the handouts",
  "from my lecture notes"), one of the kinds listed in `AGENTS.md`;
- the request to save the answer;
- the request to include saved answers, that is the files in
  `answers/`, among the sources.

## Steps

1. Identify the key concepts of the question and their synonyms.
2. Search `notes/`, `projects/`, `areas/` and `journal/`: titles, tags
   and text. Do not search `archive/` unless the question calls for it
   or the rest is not enough. Search `answers/` only if the user asked
   to include saved answers. Never search `archive/answers/`: those
   answers have already been distilled into notes.
3. Read the relevant notes in full and follow their links one level
   deep, to gather context. Read the relevant saved answers in full too,
   if included.
4. If the question is restricted to a kind of source, keep only the
   notes whose `source` list has that kind and, in notes with several
   kinds, only the paragraphs marked with it.
5. Build the answer from what the notes say. Saved answers are a
   secondary source: use them to add what the notes do not cover, never
   to override a note. Ignore the part of a saved answer marked as
   general knowledge: only what it drew from the notes counts.
6. If the notes (and, if included, the saved answers) are not enough to
   answer, say so explicitly. You may add general knowledge only in a
   separate part, marked as such.

## Output

- The answer, citing for every claim the file it comes from, with its
  path from the archive root and, when known, the kind of source:
  `notes/poisson-process.md` (handout). Claims taken from a saved
  answer cite its path in `answers/` and say that it is a saved answer,
  not a note.
- If the question was restricted to a kind of source, say so, and
  point out where other kinds of source disagree.
- If any, the gaps: what is missing from the archive to answer well.
- If any, the contradictions: notes that say incompatible things, or a
  saved answer that disagrees with a note.

The chat answer may be read in a terminal, where math is not rendered,
and many chat interfaces treat backslashes as escapes (`\,` becomes
`,`). So, in the chat answer:

- math is written in Unicode plain text, readable anywhere:
  `P(X = k) = λᵏ e^(−λ) / k!`, `∑ᵢ xᵢ`, `x ≤ √n`. Short formulas go
  inline, as inline code; longer ones in a `text` code block, one step
  per line;
- only when a formula cannot be written clearly in Unicode (matrices,
  nested fractions, complex integrals), its LaTeX source follows in a
  `latex` code block;
- diagrams go in `mermaid` blocks;
- code goes in blocks tagged with the language.

If the user asks to save the answer, also write it to
`answers/YYYY-MM-DD-topic.md` (topic in kebab-case, ASCII only; create
the folder if missing), as plain Markdown: math between `$...$` and
`$$...$$`, diagrams in `mermaid` blocks, code in blocks tagged with the
language. Start it with a level-1 heading holding the question. Keep
the citations and the marked general-knowledge part, so that the answer
can later be used as a source. In chat, a short summary and the file
path are enough.

## Constraints

- Read-only: this workflow does not edit, create or move files. The
  only exception is the file in `answers/`, and only if the user asks
  to save the answer.
- Do not attribute to the notes what they do not say. A paraphrase must
  stay faithful; when in doubt, quote the sentence.
- Never present a saved answer as a note: the reader must always know
  which claims come from notes and which from saved answers.
