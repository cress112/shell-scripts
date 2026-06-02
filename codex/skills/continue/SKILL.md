---
name: continue
description: "作業を再開または継続するときに、対象 project path を明示し、`HOME` 配下にあるその project 用の `MEMORY.md` を canonical index として過去の作業履歴を読み、現在の課題・進捗・次の行動を整理してユーザに確認する。"
---

# Continue

作業を継続するため、対象 project の memory を読み込み、続きの作業を理解する。

## Workflow

1. 対象 project path を明示する。
   - どの project の続きを再開するかを最初に確定する。
   - 基本は現在の作業ディレクトリを project root とみなし、必要ならユーザ指定の path を優先する。
   - path を曖昧なまま filesystem 全体から generic に探し始めない。
2. canonical memory root を確定する。
   - memory は project 内ではなく `HOME` 配下に置く前提で扱う。
   - 基本の入口は `~/.codex/memories/projects/<project-id>/MEMORY.md` とする。
   - `<project-id>` は次の固定ルールで導出する。
     - project path を絶対 path にする。
     - `save` と `continue` で同じ path になるよう、symlink を辿った実pathか、辿らない見かけの path かを統一して使う。迷う場合は実pathに寄せる。
     - その絶対 path 文字列の `/` をすべて `-` に置換したものを `<project-id>` とする。
     - それ以外の独自な hash や省略形を使わない。
     - 例: `/Users/user/hoge/path/to/project` -> `-Users-user-hoge-path-to-project`
   - `MEMORY.md` があるなら、まずそれを読む。
   - `MEMORY.md` を飛ばして `notes/` や `rollout_summaries/` を先に読み始めない。
3. project 固有の memory pipeline を確認する。
   - 必要に応じて次を読む。
     - `memory_summary.md`
     - `raw_memories.md`
     - `extensions/*/instructions.md`
     - `rollout_summaries/*.md`
     - `notes/*.md`
   - `extensions/*/instructions.md` に consolidation や参照順序のルールがある場合は従う。
4. `MEMORY.md` から関連 memory を辿る。
   - `MEMORY.md` に列挙された task group、keywords、関連 file、未解決事項、最新 note を起点に読む。
   - 複数ファイルがある場合は、`MEMORY.md` での関連度、最新性、ユーザ依頼との一致度で優先順位を付ける。
   - `MEMORY.md` に未統合 note や follow-up が記載されていれば、それも確認する。
5. 必要な memory を読む。
   - memory は fat である可能性がある。
   - 200行を超えるファイルは、要約だけで済ませず、対象ファイルを明示して必要な範囲を読む。
   - 読み終わった後に、`MEMORY.md` から辿るべき未読ファイルが残っていないか再確認する。
6. 状況を整理する。
   - 課題と最終的なゴール。
   - 解決済みか未解決か。
   - これまでに考えたこと。
   - 実行してうまくいったこと、うまくいかなかったこと。
   - これから実行すべきこと。
   - 次回以降に残っている課題。
7. ユーザに確認する。
   - どの project path とどの memory files を読んだかを先に明示する。
   - memory の内容を簡潔に説明する。
   - 次のアクション案を提示する。
   - 実装や追加作業に進む前に、ユーザの指示を仰ぐ。

## Output

ユーザへの説明は、再開に必要な情報だけに絞る。memory が不足している、古い、または矛盾している場合は、その不確実性を明記して確認する。`MEMORY.md` から辿れない note が見つかった場合は、その時点で retrieval が壊れていることを明示する。project 内の tracked file に memory を新規作成しようとせず、`HOME` 配下の project memory を優先する。
