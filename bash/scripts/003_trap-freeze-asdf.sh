#!/usr/bin/env bash

EXEC_COMMAND="freeze-asdf"

traps=$(trap -p)
if [[ ! "$traps" =~ .*"$EXEC_COMMAND".* ]]; then
    ### ! カスタムコマンドを使用
    add-trap "$EXEC_COMMAND" EXIT
fi
