#!/usr/bin/env bash

function add-trap() {
    function __help() {
        echo "Usage: add-trap <command> <signal>"
        echo "ex) add-trap \"echo 'end'\" EXIT"
    }

    function __validate_args() {
        if [ $# -ne 2 ]; then
            __help
            return 1
        fi
    }

    function __main() {
        local new_command="$1"
        local signal="$2"

        local existing_trap
        existing_trap=$(trap -p "$signal" | sed "s/trap -- '\(.*\)' $signal/\1/")

        local resolved_command
        if [[ -n "$existing_trap" ]]; then
            resolved_command="$new_command; $existing_trap"
        else
            resolved_command=$new_command
        fi
        trap "$resolved_command" "$signal"
    }

    __validate_args "$@" || return 1
    __main "$@" || return 1
}