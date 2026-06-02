#!/usr/bin/env bash

CODEX_BASE_DIR="${SCRIPT_DIR}/codex"
CODEX_LINK_PATH="${HOME}/.codex"

AGENTS_BASE_DIR="${SCRIPT_DIR}/agents"
AGENTS_LINK_PATH="${HOME}/.agents"

if [ ! -L "$CODEX_LINK_PATH" ]; then
    ln -s "$CODEX_BASE_DIR" "$CODEX_LINK_PATH"
fi

if [ ! -L "$AGENTS_LINK_PATH" ]; then
    ln -s "$AGENTS_BASE_DIR" "$AGENTS_LINK_PATH"
fi
