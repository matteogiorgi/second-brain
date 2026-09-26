# Connect

## Purpose

Keep the link graph healthy: find notes that should cite each other and
do not, isolated notes and broken links.

## Input

The scope given by the user: a note, a folder or a tag. If none is
given, every note outside `archive/` (`answers/` contains no notes).

## Steps

1. **Broken links.** For every relative link in the scope, check that
   the target file exists.
2. **Orphan notes.** List the notes in the scope that no other note
   links to. Links from `journal/` count, links from `archive/` do not.
   Notes in `journal/` are exempt from this check.

   For steps 1 and 2 you can use `bin/links`, which runs them on the
   whole archive; then filter its output to the scope.
3. **Missing links.** For every note in the scope, identify its main
   concepts and look for other notes that deal with them without being
   linked. Propose a link only if one of the two notes really helps to
   understand the other; sharing a tag is not enough.
4. Present the findings and wait for confirmation.
5. Apply only the confirmed links, in both directions, in the
   `## Links` section or in the text.

## Output

Before confirmation, three lists:

- broken links: note, link, and whether a file with a similar name
  exists that might be the right target;
- orphan notes;
- proposed links: pair of notes and one line on why.

After confirmation, the list of changes made.

## Constraints

- Do not fix broken links yourself: propose the fix.
- Do not create new notes to fill gaps: report them.
- A few meaningful links are better than many weak ones.
