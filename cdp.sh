#!/usr/bin/env bash

function cdp() {
    current_dir=$(pwd)
    target_dir="/"
    while [ "${target_dir}" != "." ];
    do
        target_dir=$(ls -la | grep -e ^d -e ^l | peco | awk '{print $9}')
        if [ -z "${target_dir}" ]; then
            cd "${current_dir}" || exit
            return 1
        fi
        cd "${target_dir}" || return
    done

}
