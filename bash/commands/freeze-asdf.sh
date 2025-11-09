#!/usr/bin/env bash

function freeze-asdf() {
    PLUGIN_LIST_FILE="${SCRIPT_DIR}/asdf/plugins.txt"
    PLUGIN_LIST_DIR="${SCRIPT_DIR}/asdf/plugins"
    FILE_EXTENSION=txt

    function __save_plugins() {
        asdf plugin list > "${PLUGIN_LIST_FILE}"
    }

    function __list_versions() {
        if [ ! -d "$PLUGIN_LIST_DIR" ]; then
            mkdir -p "$PLUGIN_LIST_DIR"
        fi
        while read -r plugin_name; do
            __list_version "$plugin_name" > "${PLUGIN_LIST_DIR}/${plugin_name}.${FILE_EXTENSION}"
        done < "${PLUGIN_LIST_FILE}"
    }

    function __list_version() {
        plugin_name=$1
        while IFS= read -r line; do
            echo "$line" | __parse_version
        ### 有効な出力があるpluginのみ扱うため、エラー出力は捨てる
        done < <(asdf list "$plugin_name" 2>/dev/null)
    }

    function __parse_version() {
        local input
        read -r input

        echo "$input" | tr -d '*' | tr -d ' '
    }

    __save_plugins
    __list_versions
}
