#!/usr/bin/env bash

function cdp() {
    current_dir=$(pwd)
    target_dir="/"
    while [ "${target_dir}" != "." ];
    do
        target_dir=$(echo -e ".\n..\n$(find . -type d -mindepth 1 -maxdepth 1)" | peco --prompt "$(pwd)/ to ...:")
        if [ -z "${target_dir}" ]; then
            cd "${current_dir}" || exit
            return 1
        fi
        cd "${target_dir}" || return
    done

}
