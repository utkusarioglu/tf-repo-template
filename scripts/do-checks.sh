#!/bin/bash

source .scripts.config

check_dependencies() {
  if [ -z $1 ];
  then
    echo "Error: \`check_dependencies\` requires at least one param to be provided"
    exit 11
  fi

  for exec in $@;
  do
    if [ -z $(which $exec) ];
    then 
      echo "Error: This script requires $exec to be available in the system"
      exit 12
    fi
  done
}

check_tfvars() {
  if [ -z $TFVARS_FILE_PATH ];
  then
    echo ".scripts.config file needs to define the \$TFVARS_FILE_PATH for this script to work."
    exit 13
  fi
}
