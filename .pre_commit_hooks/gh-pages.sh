#!/usr/bin/env bash
# pre-commit hook using ghp-import to push HTML to Github Pages.
# Assumes:
#		HTML exists in docs foler.
#		ghp-import in PATH, e.g., `python -m pip install ghp-import`.
#		`git config ghppages.pathhtml <absolute path>/docs`. Defaults to
#		"$GIT_WORK_TREE/docs".
#		`git config ghppages.push true`. Otherwise skip publishing.

if git config --get-colorbool color.interactive
then
	# See https://github.com/vimwiki/vimwiki/blob/master/doc/logo.svg
	say_prefix='\e[90mghp\e[92m|\e[37mimport\e[0m'
else
	say_prefix='ghp-import'
fi

say () {
	printf '%b: %s' "$say_prefix" "$*"
}

say_done () {
	printf 'done.\n'
}

# Exit if no changes staged for commit
if git diff --cached --diff-filter=tuxb --quiet
then
	exit 0
fi

# Stash untracked changes
git stash push --keep-index --include-untracked --quiet >/dev/null 2>&1

trap 'git stash pop --quiet >/dev/null 2>&1' 0
trap 'exit 1' 1 2 3 15

# Update gh-pages
if test "$(git config --bool ghppages.push || echo false)" = true
then
	pathhtml=$(git config ghppages.pathhtml || echo "$GIT_WORK_TREE/docs")
	say 'Pushing html to gh-pages...'
	ghp-import -n -o -p -f "$pathhtml"
	say_done
fi
