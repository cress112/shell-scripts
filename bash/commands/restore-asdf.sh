#!/usr/bin/env bash

### ! 変数設定がfreeze-asdfに依存している
function restore-asdf() {
    PLUGIN_LIST_FILE="${SCRIPT_DIR}/asdf/plugins.txt"
    PLUGIN_LIST_DIR="${SCRIPT_DIR}/asdf/plugins"
    FILE_EXTENSION=txt

    function __add_plugins() {
        while read -r plugin_name; do
            __add_plugin "$plugin_name"
        done < "${PLUGIN_LIST_FILE}"
    }

    function __add_plugin() {
        local plugin_name=$1
        asdf plugin add "$plugin_name"
    }

    function __install_versions() {
        while read -r plugin_name; do
            __install_version "$plugin_name"
        done < "${PLUGIN_LIST_FILE}"
    }

    function __install_version() {
        local plugin_name=$1
        while read -r version; do
            asdf install "$plugin_name" "$version"
        done < <(cat "${PLUGIN_LIST_DIR}/${plugin_name}.${FILE_EXTENSION}")
    }

    __add_plugins
    __install_versions
}