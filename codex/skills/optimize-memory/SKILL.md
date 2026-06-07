---
name: optimize-memory
description: "project-scoped SQLite memory を軽量化するときに使う。完了済みで恒常知識を含まない ephemeral entry だけを `~/.codex/scripts/codex-memory optimize --apply --delete` で削除し、恒常知識・active/open/pinned memory は保持する。"
---

# Optimize Memory

対象 project の SQLite memory を軽量化する。候補一覧は出さず、件数だけ報告する。

## Workflow

1. 対象 project path を明示する。
   - 基本は現在の作業ディレクトリを project root とみなし、必要ならユーザ指定の path を優先する。
   - path を曖昧なまま最適化しない。
2. SQLite CLI を実行する。
   - 通常運用では `~/.codex/scripts/codex-memory optimize --project <path> --apply --delete` を使う。
   - DB の既定パスは `~/.codex/sqlite/user-memory.sqlite`。
   - Markdown memory ファイルは読まない、作成しない、更新しない。
3. 削除ポリシーを守る。
   - CLI は `status=completed`、`permanence=ephemeral`、`pinned=0`、`archived_at IS NULL`、`superseded_by IS NULL` の entry だけを対象にする。
   - `decision`, `principle`, `project_goal`, `user_preference`, `constraint`, `context`, `open_item` は削除しない。
   - metadata に `contains_permanent_facts` または `has_open_items` が true の entry は削除しない。
   - `permanence` は保存時の明示指定をそのまま使う。削除対象にしたい作業ログは保存時に `ephemeral` を付ける。
4. 報告は短くする。
   - 候補 entry の本文や一覧は表示しない。
   - `permanent_kept`, `active_kept`, `candidates`, `skipped_for_flags`, `deleted` だけを要約する。

## Command

```bash
~/.codex/scripts/codex-memory optimize --project "$PWD" --apply --delete
```

## Safety

この skill はユーザ確認なしで物理削除を実行する前提で設計されている。削除できるのは、保存時点で完了済みかつ一時的だと明示された memory だけである。分類が曖昧な entry は残す。
