#!/usr/bin/env bash

function list-commands() {
    COMMANDS_DIR="${SCRIPT_DIR}/bash/commands"
    while IFS= read -r file; do
        echo "$file"
    done < <(ls "$COMMANDS_DIR")
}