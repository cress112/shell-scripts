#!/use/bin/env bash

function yt {
    current_dir=$(pwd)
    
    cd ~/Downloads/other_programs/20240810_shell-scripts || exit
    yt-dlp/yt-dlp.sh "$@"

    cd "${current_dir}" || exit
}