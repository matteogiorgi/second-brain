#!/bin/sh
# init.sh: create a second brain archive, or complete an existing one
#
# usage:
#   init.sh [--claude] [--vim] [--docs] [--all] folder
#
# The core (folders, AGENTS.md, workflows/, bin/) is always created;
# the options add the adapters and the documentation notes.
# The folder is required and can be anywhere: you can create several
# archives. The first one becomes the default: the script appends BRAIN
# and PATH to ~/.profile, unless BRAIN is already there.
# No existing file is ever overwritten: re-running the script is always
# safe.

# -e: stop at the first failing command; -u: treat unset variables as
# errors instead of silently expanding them to an empty string
set -eu

# print the help; $(basename "$0") is the name the script was run as
usage() {
    cat <<EOF
usage: $(basename "$0") [options] folder

  --claude   Claude Code adapter (CLAUDE.md, .claude/commands/)
  --vim      Vim adapter (editors/vim/brain.vim)
  --docs     notes documenting the system (areas/, notes/)
  --all      all of the above
  -h         show this help

folder: where to create the archive (required; you can create more than one)
EOF
}

# print an error on standard error and exit
die() {
    echo "init.sh: $*" >&2
    exit 1
}

# the templates sit next to the script, whatever directory it is run
# from: resolve the script's folder to an absolute path
tpl="$(cd "$(dirname "$0")" && pwd -P)/template"
[ -d "$tpl/core" ] || die "templates not found in $tpl"

# parse the options: each one sets a variable to its layer's name (the
# subfolder of template/), empty means "not chosen"; the first
# argument that is not an option ends the loop and must be the folder
claude='' vim='' docs=''
while [ $# -gt 0 ]; do
    case $1 in
    --claude) claude=claude ;;
    --vim) vim=vim ;;
    --docs) docs=docs ;;
    --all) claude=claude vim=vim docs=docs ;;
    -h | --help)
        usage
        exit 0
        ;;
    -*) die "unknown option: $1 (see -h)" ;;
    *) break ;;
    esac
    shift
done
[ $# -eq 1 ] || die "exactly one folder is required (see -h)"
# the layers to install, in order; empty variables vanish when the
# list is split in the for loop below
layers="core $claude $vim $docs"

# the destination may exist, but only as a folder; once created, turn
# it into an absolute path, which is what goes into ~/.profile
dest=$1
[ ! -e "$dest" ] || [ -d "$dest" ] || die "$dest exists and is not a folder"
mkdir -p "$dest"
dest=$(cd "$dest" && pwd -P)
echo "archive: $dest"

# core folders, even empty ones
for d in inbox notes projects areas journal archive/inbox workflows bin; do
    mkdir -p "$dest/$d"
done

# copy a layer's files, never overwriting
copy_layer() {
    # list the layer's files (hidden ones too, like .gitignore) as
    # paths relative to the layer, such as ./bin/capture
    (cd "$tpl/$1" && find . -type f | sort) | while read -r f; do
        f=${f#./} # strip the leading ./
        if [ -e "$dest/$f" ]; then
            echo "  exists, left alone: $f"
        else
            # create the file's folder first (e.g. .claude/commands/)
            mkdir -p "$dest/$(dirname "$f")"
            cp "$tpl/$1/$f" "$dest/$f"
            echo "  created: $f"
        fi
    done
}

for l in $layers; do
    echo "[$l]"
    copy_layer "$l"
done

# the scripts must be executable to run as commands
chmod +x "$dest"/bin/*

# git does not track empty folders: an empty .gitkeep file keeps each
# one in the repository (ls -A lists hidden files too, so a folder with
# only a .gitkeep already counts as not empty)
for d in inbox notes projects areas journal archive/inbox; do
    if [ -z "$(ls -A "$dest/$d")" ]; then
        touch "$dest/$d/.gitkeep"
    fi
done

# create the git repository, unless there is one already or git is
# missing; no commit is made, the first one is left to the user
if [ -d "$dest/.git" ]; then
    echo "git: repository already present"
elif command -v git >/dev/null 2>&1; then
    git -C "$dest" init -q
    echo "git: repository created"
else
    echo "git: not installed, repository not created" >&2
fi

# the first archive becomes the default: BRAIN and PATH in ~/.profile.
# If the profile already exports BRAIN, check whether it names this
# archive (other stays empty) or another one (other=1); otherwise
# append the lines (added=1). Both flags drive the next steps below.
profile="$HOME/.profile"
added='' other=''
# the last "export BRAIN=" line, if any (the one that wins at login)
line=$(grep '^export BRAIN=' "$profile" 2>/dev/null | tail -n 1)
if [ -n "$line" ]; then
    # the value as written: drop "export BRAIN=" and the quotes, then
    # expand a leading $HOME, ${HOME} or ~ by hand, as the shell would
    val=$(printf '%s\n' "${line#export BRAIN=}" | tr -d "\"'")
    # '$HOME' in single quotes is the literal text to match, on purpose
    # shellcheck disable=SC2016
    case $val in
    '$HOME'*) val=$HOME${val#'$HOME'} ;;
    '${HOME}'*) val=$HOME${val#'${HOME}'} ;;
    '~'*) val=$HOME${val#'~'} ;;
    esac
    # compare absolute paths, with symlinks resolved like $dest
    if [ "$(cd "$val" 2>/dev/null && pwd -P)" = "$dest" ]; then
        echo "profile: this is already the default archive"
    else
        other=1
        echo "profile: $profile already sets a default archive, left alone"
    fi
else
    added=1
    {
        echo
        echo "# second brain (added by init.sh)"
        echo "export BRAIN=\"$dest\""
        # \$ writes a literal $: the profile expands it at login
        echo "PATH=\"\$BRAIN/bin:\$PATH\""
    } >>"$profile"
    echo "profile: BRAIN and PATH appended to $profile"
fi
# bash reads ~/.profile at login only if neither of these exists
if [ -e "$HOME/.bash_profile" ] || [ -e "$HOME/.bash_login" ]; then
    echo "profile: warning, at login bash reads ~/.bash_profile (or ~/.bash_login), not ~/.profile" >&2
fi

# next steps, depending on the chosen options
# step prints a numbered line, counting with n
n=0
step() {
    n=$((n + 1))
    printf '  %d. %s\n' "$n" "$1"
}

echo
echo "Done. Next steps:"
[ -z "$added" ] || step "log in again, or load the profile now: . ~/.profile"
[ -z "$other" ] || step "not the default archive: capture and links use it when run from inside its folder"
if [ -n "$vim" ]; then
    step "in your vimrc: execute 'source' \$BRAIN . '/editors/vim/brain.vim'"
    step "with tmux, in ~/.tmux.conf: set -g focus-events on"
fi
[ -z "$claude" ] || step "run Claude Code inside the archive: it reads CLAUDE.md and offers /triage, /ask and /connect"
step "read AGENTS.md and complete it with what the agent needs to know"
step "first commit: cd \"$dest\" && git add -A && git commit -m \"Initial archive\""
