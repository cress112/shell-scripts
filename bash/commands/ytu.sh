#!/usr/bin/env bash

YT_DIR="${SCRIPT_DIR}/yt-dlp"

function ytu {
    current_dir=$(pwd)

    cd "${YT_DIR}" || exit
    git pull

    cd "${current_dir}" || exit
}