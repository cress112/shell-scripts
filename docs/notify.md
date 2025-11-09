# notifi-via-python.sh
## 概要
- MacOSのマシンで、任意時刻に任意内容の通知をするタスクを作成できる

## 要求環境
- Python >= 3.11
- bash

## 使用法
- 通知タスクの作成
    ```bash
    $ notify [<通知時刻>] [<通知タイトル>] [<通知内容>]
    ```
    - ex) `notify 21:34 "会議の準備" "zoom, 内容はTimeTree参照"`
- help
    ```bash
    $ notify -h
    ```

## 動作解説
- トップレベルで呼ばれたシェルスクリプトが2つのタスクを起動する
    1. configファイルの作成
        - トップレベル上で動作
        - `shell-scripts/python-sources/.notice-config.json`を生成する
    2. 通知タスクの作成
        - バックグラウンドで動作(+`nohup`)
        - 上で作成したjsonファイルを参照して通知タスクを作成する
        - 現在時刻と実行時刻の差を求めて、その時間だけ`sleep`している
        - `hh:mm`のみ参照しているため、日を超えることはできない
