#!/bin/bash

scripts/terraform.sh init

cd tests && go mod tidy && cd ..

scripts/git-update-status.sh
