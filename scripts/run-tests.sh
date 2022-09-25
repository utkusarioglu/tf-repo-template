#!/bin/bash

echo "Starting Terratest…"
cd tests && go test -timeout 90m && cd ..
