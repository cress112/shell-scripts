#!/use/bin/env bash

YT_DIR="${SCRIPT_DIR}/yt-dlp"
YT_DOWNLOAD_DIR="${HOME}/Downloads"

function yt {
    "${YT_DIR}"/yt-dlp.sh "$@"
}

function yt-list {
    args=($@)

    if [ -z $args ]; then
        echo "Usage: yt-list <url> [yt-options]"
        return 1
    fi

    yt "${args[0]}" --list-formats --skip-download "${args[@]:1}"
}

function yt-dl {
    args=($@)

    if [ -z $args ]; then
        echo "Usage: yt-dl <url> [yt-options]"
        echo "in most cases, you should specify format"
        return 1
    fi

    yt "${args[0]}" --output "${YT_DOWNLOAD_DIR}"/'%(upload_date)s_%(title)s.%(ext)s' --write-thumbnail "${args[@]:1}"
}