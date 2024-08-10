#!/bin/bash

function __notify_usage {
    cat <<EOF
Create Python Process to Notify Specific Message
Usage:
    notify [<Time to notify(hh:mm)>] [<Title of notice>] [<Message of notice>]
    notify [<option>...]
Options:
    -h|--help		Show this help
EOF
}



function notify {

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

    # atdに渡して通知設定
    # echo "osascript -e 'display notification \"${message}\" with title \"${title}\"'" | at ${run_time}
    python ${SCRIPT_DIR}/python-sources/atrun-config.py --runtime ${run_time} --title ${title} --message ${message}
    nohup python ${SCRIPT_DIR}/python-sources/wait-and-notice.py >/dev/null 2>&1 &
    
}
