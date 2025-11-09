#!/usr/bin/env bash

BASH_COMMANDS_DIR="${SCRIPT_DIR}/bash/commands"

commands=($(ls "${BASH_COMMANDS_DIR}" | grep '\.sh$'))
for command in "${commands[@]}"; do
    source "${BASH_COMMANDS_DIR}/${command}"
done
