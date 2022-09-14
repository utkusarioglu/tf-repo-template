#!/bin/bash

shopt -s expand_aliases || exit 1
source ~/.bash_aliases || exit 2
source .scripts.config || exit 3
source ${0%/*}/do-checks.sh || exit 4

check_dependencies jq
check_tfvars

command=$1
if [ -z $command ];
then
  echo "Error: The first param needs to be a valid Terraform command." 
  echo "Example: apply"
  exit 5
fi

repo_root=$PWD
project_root_rel_path=$(jq '.project_root_rel_path' $TFVARS_FILE_PATH -r)
project_root=$(readlink -m $repo_root/$project_root_rel_path)
repo_rel_path="${repo_root#"$project_root/"}"

cd $project_root
if [ -z $repo_rel_path ];
then
  echo "Running \`terraform $command\` at current path…"
  terraform $command 
else
  echo "Running \`terraform $command\` at \`$repo_rel_path\`…"
  terraform -chdir="$repo_rel_path" $command 
fi
cd $repo_root
