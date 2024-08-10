# 概要
- シェルスクリプトの寄せ集め
- 全て関数形式にしてあるため、`bashrc`に設定の書き込みが必要


# 環境構築
- ソースをclone & cd
    ```bash
    $ git clone https://github.com/cress112/shell-scripts.git
    $ cd shell-scripts
    ```
- `~/.bashrc`に以下の記述を追加
    ```bash
    $ vi ~/.bashrc
        .
        .
        .
    export SCRIPT_DIR=~/documents/bash-scripts
    scripts=($(ls ${SCRIPT_DIR} | grep .sh))
    for script in ${scripts[@]}; do
        source "${SCRIPT_DIR}/${script}"
    done
    ```
    - ソースプログラムで`SCRIPT_DIR`を参照しているため, `export`している
- シンボリックリンクを作成
    ```bash
    $ ln -s `pwd` ~/documents/bash-scripts
    ```
- `bashrc`読み込み
    ```bash
    $ source ~/.bashrc
    ```

# 詳説
- [`notify-via-python.sh`](./notify-via-python.md)