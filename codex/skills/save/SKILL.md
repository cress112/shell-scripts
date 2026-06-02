---
name: save
description: "`HOME` 配下の project ごとの memory に作業履歴を保存するときに、対象 project path を明示し、`MEMORY.md` を canonical index として更新しながら、他の Agent が再開できる形で記録する。"
---

# Save

これまで実施したタスクの内容を、対象 project の memory に保存する。

## Workflow

1. 対象 project path を明示する。
   - どの project の memory を更新するかを明示的に確定する。
   - 基本は現在の作業ディレクトリを project root とみなし、必要ならユーザ指定の path を優先する。
   - path を曖昧なまま保存しない。
2. canonical memory root を確定する。
   - memory は commit 対象にしないため、保存先は project 内ではなく `HOME` 配下に置く。
   - 基本の保存先は `~/.codex/memories/projects/<project-id>/` とする。
   - canonical index は `~/.codex/memories/projects/<project-id>/MEMORY.md` とする。
   - `<project-id>` は次の固定ルールで導出する。
     - project path を絶対 path にする。
     - `save` と `continue` で同じ path になるよう、symlink を辿った実pathか、辿らない見かけの path かを統一して使う。迷う場合は実pathに寄せる。
     - その絶対 path 文字列の `/` をすべて `-` に置換したものを `<project-id>` とする。
     - それ以外の独自な hash や省略形を使わない。
     - 例: `/Users/user/hoge/path/to/project` -> `-Users-user-hoge-path-to-project`
   - 関連ファイルがある場合は、少なくとも次を確認する。
     - `memory_summary.md`
     - `raw_memories.md`
     - `extensions/*/instructions.md`
     - `notes/*.md`
     - `extensions/ad_hoc/notes/*.md` (legacy)
     - `rollout_summaries/*.md`
   - 既存構成があるならそれに従うが、入口は常に `MEMORY.md` に寄せる。
3. 詳細 memory を保存する。
   - task の詳細は `~/.codex/memories/projects/<project-id>/notes/<timestamp>-<slug>.md` に保存する。
   - filename は task を識別できる短い slug にする。
   - 既存 note を上書きするより、新規 note を積み増す方を優先する。
4. `MEMORY.md` を canonical index として更新する。
   - 保存した note の path を `MEMORY.md` から必ず辿れるようにする。
   - task group、keywords、関連 file、未解決事項、次回読むべき note を追記または更新する。
   - `MEMORY.md` を見れば、その project の主要 memory と最新 task の所在が分かる状態にする。
5. 必要なら補助ファイルも更新する。
   - `extensions/*/instructions.md` に consolidation ルールがある場合は従う。
   - `memory_summary.md` や `raw_memories.md` が運用上の入口になっている project memory では、必要な範囲で整合を取る。
   - note だけ書いて index 未更新の状態で終わらない。
6. 作業履歴を整理する。
   - 課題と最終的なゴールを明記する。
   - 課題は解決できたかどうかを `y` または `n` で明記する。
   - 課題を解決するために考えたことを明記する。
   - これまでに実行し、うまくいったことを明記する。
   - これまでに実行し、うまくいかなかったことを明記する。
   - これから実行すべきことを明記する。
   - 次回以降の課題を明記する。
7. 再開可能性を確認する。
   - 他の Agent が memory だけを見ても作業を再開できる粒度にする。
   - ファイルパス、コマンド、検証結果、未解決の判断事項を具体的に残す。
   - 推測と確認済み事実を混ぜない。
8. 保存後に報告する。
   - project path と memory root をユーザに伝える。
   - 保存した note の path と、更新した `MEMORY.md` の path をユーザに伝える。
   - 残タスクがある場合は、次にやるべきことを短く添える。

## Memory Format

```markdown
# Task Memory: <short task name>

## Goal
- 課題:
- 最終ゴール:
- 解決済み: y/n

## Context
- 背景:
- 重要な制約:

## Reasoning
- 考えたこと:
- 判断理由:

## Actions
- うまくいったこと:
- うまくいかなかったこと:
- 実行した主なコマンド:
- 変更した主なファイル:

## Verification
- 確認できたこと:
- 未確認のこと:

## Next Actions
- これから実行すべきこと:
- 次回以降の課題:
```

## Index Requirements

`MEMORY.md` には少なくとも次の情報を残す。

- 対象 project path
- `~/.codex/memories/projects/<project-id>/` への対応
- `<project-id>` の導出元になった絶対 path
- task group または task 名
- 保存した note の path
- 検索に使う keywords
- 未解決事項
- 次回読むべき関連 file または summary
