#!/usr/bin/env bash

function ytu {
    current_dir=$(pwd)
    
    cd ~/Downloads/other_programs/20240810_shell-scripts/yt-dlp || exit
    git pull

    cd "${current_dir}" || exit

}