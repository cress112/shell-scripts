#!/usr/bin/env bash

function pdfe() {
    PDFEDITOR_DIR="${SCRIPT_DIR}/../20210627_PDFEditor"
    EXEC_COMMAND='uv run main.py'

    current_dir=$(pwd)
    cd "$PDFEDITOR_DIR" || exit
    bash -c "$EXEC_COMMAND" || true
    cd "$current_dir" || exit
}