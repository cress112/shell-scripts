#!/usr/bin/env bash

BASHRC_PATH="${SCRIPT_DIR}/bash/.bashrc"
BASH_SCRIPTS_DIR="${SCRIPT_DIR}/bash/scripts"

function __get-shell-name() {
    IFS='/'
    shell_path=(${SHELL})
    echo "${shell_path[-1]}"
}

function __load-bashrc() {
    shell_name=$1
    if [ $shell_name = 'bash' ]; then
        source "${BASHRC_PATH}"
    fi
}

function __load-scripts() {
    shell_name=$1
    if [ $shell_name = 'bash' ]; then
        scripts=($(ls "${BASH_SCRIPTS_DIR}" | grep '\.sh$'))
        for script in "${scripts[@]}"; do
            source "${BASH_SCRIPTS_DIR}/${script}"
        done
    fi
}

shell_name=$(__get-shell-name)
__load-bashrc "${shell_name}"
__load-scripts "${shell_name}"

unset -f __get-shell-name
unset -f __load-bashrc
unset -f __load-scripts