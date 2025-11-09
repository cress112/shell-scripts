# 概要
- シェルスクリプトの寄せ集め
- 全て関数形式にしてあるため、`bashrc`に設定の書き込みが必要


# 環境構築
- ソースをclone & cd
    ```bash
    git clone https://github.com/cress112/shell-scripts.git
    cd shell-scripts
    pwd
    ```
- `~/.bashrc`に以下の記述を追加
    ```sh
    export SCRIPT_DIR=<このソースディレクトリの絶対パス>

    scripts=($(ls "${SCRIPT_DIR}" | grep '\.sh'))
    for script in "${scripts[@]}"; do
        source "${SCRIPT_DIR}/${script}"
    done
    ```
- `bashrc`読み込み
    ```bash
    $ source ~/.bashrc
    ```

# 詳説
- [`notify.sh`](./Docs/notify.md)