#!/usr/bin/env bash

if [ ! -e "$CUSTOM_BIN_PATH" ]; then
    mkdir -p "$CUSTOM_BIN_PATH"
fi

# json2cuesheet
base_path="${HOME}/Downloads/other_programs/20251130_json2cuesheet-rs/target/release/json2cuesheet"
target_path="${CUSTOM_BIN_PATH}/json2cuesheet"
existing_link=$(readlink "$target_path")
if [ "$existing_link" != "$base_path" ]; then
    ln -sf "$base_path" "$target_path"
fi
