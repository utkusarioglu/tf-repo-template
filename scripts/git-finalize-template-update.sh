#!/bin/bash

echo "Warn: This is an experimental script that still leaves a lot to be desired."
echo "Do not call this script unless you know what you are doing."

update_branch=$(git branch --show-current)
rebase_branch=$1

if [[ "$update_branch" != "chore/"*"-template-update" ]]; then
  echo "Error: You are not on a template update branch."
  exit 1
fi

if [ -z "$rebase_branch" ]; then
  rebase_branch="main"
fi

git checkout $rebase_branch
git rebase $update_branch
git branch -d $update_branch
