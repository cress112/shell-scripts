#!/usr/bin/env bash

USER_SETTING_JSON_FILES_DIR="${SCRIPT_DIR}/vscode"
VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"

settings=($(ls "${USER_SETTING_JSON_FILES_DIR}" | grep '\.json$'))
for setting in "${settings[@]}"; do
    existing_link=$(readlink "${VSCODE_USER_DIR}/${setting}")
    if [ "$existing_link" != "${USER_SETTING_JSON_FILES_DIR}/${setting}" ];then
        ln -sf "${USER_SETTING_JSON_FILES_DIR}/${setting}" "${VSCODE_USER_DIR}/${setting}"
        echo "CAUTION: new link created: ${VSCODE_USER_DIR}/${setting}"
    fi
done
