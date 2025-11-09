#!/usr/bin/env bash

YT_DIR="${SCRIPT_DIR}/yt-dlp"
YT_GIT_URL="https://github.com/yt-dlp/yt-dlp"

if [ ! -e "${YT_DIR}/yt-dlp.sh" ]; then
    mkdir -p "$YT_DIR"
    git clone "$YT_GIT_URL" "$YT_DIR"
fi