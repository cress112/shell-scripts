---
name: save
description: "作業履歴や判断を project-scoped SQLite memory に保存するときに使う。Markdown memory は作成・更新せず、`~/.codex/scripts/codex-memory` 経由で `~/.codex/sqlite/user-memory.sqlite` に保存する。"
---

# Save

これまで実施したタスクの内容を、対象 project の SQLite memory に保存する。

## Workflow

1. 対象 project path を明示する。
   - 基本は現在の作業ディレクトリを project root とみなし、必要ならユーザ指定の path を優先する。
   - path を曖昧なまま保存しない。
2. 保存内容を短く構造化する。
   - `kind` は主に `task`, `decision`, `context`, `verification`, `open_item` から選ぶ。
   - 完了済みで再利用しない作業ログは `--status completed --permanence ephemeral` を付ける。
   - 設計原則、project 目的、ユーザ preference、重要な制約、判断は `--permanence permanent` を付ける。
   - 未解決の作業や follow-up は `--status active` または `--kind open_item` にする。
   - `open_item` は既定で `permanent` になる。セッションをまたいで保持したい未解決事項だけ既定値のまま使う。
   - 一時的な follow-up を active のまま残したいだけなら、`--kind task --status active --permanence normal` を明示する。
   - `--permanence normal` や `ephemeral` を明示した場合、その指定が優先される。
   - `title` は検索しやすい短い名前にする。
   - `body` は再開に必要な事実、判断、検証結果、次の行動だけに絞る。
   - 長い会話ログや Markdown の丸写しは保存しない。
3. SQLite CLI を使って保存する。
   - 必ず `~/.codex/scripts/codex-memory add` を使う。
   - DB の既定パスは `~/.codex/sqlite/user-memory.sqlite`。
   - Markdown memory ファイル、`MEMORY.md`、`notes/*.md`、`rollout_summaries/*.md` は作成・更新しない。
4. 保存後に確認する。
   - `~/.codex/scripts/codex-memory search` または `recent` で保存できたことを確認する。
   - 報告では DB path、project path、entry id、title を伝える。

## Commands

```bash
~/.codex/scripts/codex-memory add \
  --project "$PWD" \
  --kind task \
  --status completed \
  --permanence ephemeral \
  --title "short searchable title" \
  --body "compact reusable memory body" \
  --metadata-json '{"contains_permanent_facts": false, "has_open_items": false}'
```

```bash
~/.codex/scripts/codex-memory add \
  --project "$PWD" \
  --kind decision \
  --status active \
  --permanence permanent \
  --title "stable project decision" \
  --body "compact permanent fact"
```

```bash
~/.codex/scripts/codex-memory add \
  --project "$PWD" \
  --kind task \
  --status active \
  --permanence normal \
  --title "next session follow-up" \
  --body "compact active but non-permanent follow-up"
```

```bash
~/.codex/scripts/codex-memory recent --project "$PWD" --limit 5
```

## Memory Body

本文には次を短く含める。

- Goal: 何を解決しようとしたか。
- Result: 解決済みか、未解決か。
- Decisions: 後続 agent が引き継ぐべき判断。
- Evidence: 重要な file path、command、検証結果。
- Next: 次にやること。

## Optimize Compatibility

`optimize-memory` は `status=completed` かつ `permanence=ephemeral` で、metadata の `contains_permanent_facts` と `has_open_items` が false の entry だけを削除する。保存時に分類を曖昧にすると削除されず残る。
