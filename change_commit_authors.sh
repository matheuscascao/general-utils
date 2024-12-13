#!/bin/bash
# Edit the history of a git repository to change the author of the commits. It changes all commits to a random author from the list of authors.
# run: chmod +x change_commit_authors.sh; ./change_commit_authors.sh

AUTHORS=(
    "matheuscascao <matheusfranco23@hotmail.com>"
    "username_1 <user@email.com>"
)

LENGTH=${#AUTHORS[@]}

git filter-branch --env-filter '

LENGTH=${#AUTHORS[@]}

AUTHOR=${AUTHORS[$((RANDOM % LENGTH))]}

GIT_AUTHOR_NAME=$(echo $AUTHOR | awk "{print \$1}")
GIT_AUTHOR_EMAIL=$(echo $AUTHOR | awk "{print \$2}" | tr -d "<>")

GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

export GIT_AUTHOR_NAME
export GIT_AUTHOR_EMAIL
export GIT_COMMITTER_NAME
export GIT_COMMITTER_EMAIL
' -- --all

rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now