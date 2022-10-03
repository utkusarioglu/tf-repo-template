#!/bin/bash

echo "Warn: This is an experimental script. It may cause data loss!"
echo "Use at your own risk."

update_mode=$1

if [[ "$update_mode" != "repo" ]] && [[ "$update_mode" != "parent" ]];
then
  echo "Error: Update mode can only be \`parent\` or \`repo\`"
  exit 1
fi

if [[ $update_mode == "parent" ]];
then
  check_parent_template_config
fi

branch_to_delete=chore/${update_mode}-template-update

if [[ $(git branch) != *"$branch_to_delete"* ]];
then
  cat << EOF
Error: There is no branch named '$local_staging_branch'. 
The reset operation will halt in order not to cause any damage.
EOF
  exit 2
fi

git checkout main
git reset --hard HEAD
git clean -fd
git branch -D $branch_to_delete
