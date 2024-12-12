#!/bin/bash

echo "Checking for breaking changes..."
breakingChangeResult=$(buf breaking --against '.git#branch=main')
if [[ $breakingChangeResult ]]; then
    echo "$breakingChangeResult"
    echo "Breaking changes detected, aborting."
    exit 1
fi

echo "Running lint check..."
lintResult=$(buf lint)
if [[ $lintResult ]]; then
    echo "$lintResult"
    echo "Lint errors detected, aborting."
    exit 1
fi

echo "Generating files from .proto definitions..."
buf generate

echo "Done."
