#!/usr/bin/env bash

YT_DIR="${SCRIPT_DIR}/yt-dlp"
YT_DOWNLOAD_DIR="${HOME}/Downloads"

### ! DL処理がffmpegに流れる場合
### pip install pycryptodomex

function yt {
    "${YT_DIR}/yt-dlp.sh" "$@"
}

function yt-list {
    yt --list-formats --skip-download "$@"
}

function yt-dl {
    yt --output "${YT_DOWNLOAD_DIR}/%(upload_date)s_%(title)s.%(ext)s" --write-thumbnail "$@"
}

function ytjs {
    "${YT_DIR}/yt-dlp.sh" --js-runtimes node:$(which node) --remote-components ejs:github "$@"
}

function ytjs-list {
    ytjs --list-formats --skip-download "$@"
}

function ytjs-dl {
    ytjs --output "${YT_DOWNLOAD_DIR}/%(upload_date)s_%(title)s.%(ext)s" "$@"
}