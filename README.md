# 概要
- 下記寄せ集め
  - bashrc定義
  - bashログインシェルで使用したいコマンド定義
  - 起動時実行コマンド類

# 想定環境
- OS: MacOS(>=12.x)
- シェル: bash(5.x)

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