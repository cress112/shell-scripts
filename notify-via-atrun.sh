#!/bin/bash

function __notify_usage {
    cat <<EOF
Usage:
    notify [<Time to notify(hh:mm)>] [<Title of notice>] [<Message of notice>]
    notify [<option>...]
Options:
    -h|--help		Show this help
EOF
}



function notify {

    # 定義類
    TEMP_FILENAME="./.temp-atrun-notice.script"

    # 引数取得
    run_time=$1
    title=$2
    message=$3

    # オプション処理
    while [ -n "${1:-}" ]; do
        case "$1" in
            -h|--help)
                __notify_usage
                return 0;;
            "") break;;
        esac
        shift
    done

    if [ "${message}" = "" ]; then
        echo "引数の指定が不正です。"
        __notify_usage
        return 1
    fi


    # 通知文作成してAppleScriptの中間ファイル作成
    echo "display notification \"${message}\" with title \"${title}\"" > ${TEMP_FILENAME}
    
    # atdに渡して通知設定
    echo "osascript ${TEMP_FILENAME}" | at $run_time
    osascript ${TEMP_FILENAME}

    # 中間ファイルを削除
    rm -f $TEMP_FILENAME
    
}
