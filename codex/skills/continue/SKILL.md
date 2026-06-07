---
name: continue
description: "作業を再開または継続するときに、対象 project path を明示し、project-scoped SQLite memory を `~/.codex/scripts/codex-memory` で検索して現在の課題・進捗・次の行動を整理する。Markdown memory は読まない。"
---

# Continue

作業を継続するため、対象 project の SQLite memory を読み込み、続きの作業を理解する。

## Workflow

1. 対象 project path を明示する。
   - 基本は現在の作業ディレクトリを project root とみなし、必要ならユーザ指定の path を優先する。
   - path を曖昧なまま filesystem 全体から探し始めない。
2. SQLite CLI で compact context を取得する。
   - 必ず `~/.codex/scripts/codex-memory context --project <path>` を使う。
   - ユーザの依頼に検索語がある場合は `search --query <terms>` も使う。
   - DB の既定パスは `~/.codex/sqlite/user-memory.sqlite`。
   - `context` は completed ephemeral entry を通常再開文脈から除外する。
   - `context`, `search`, `recent` は参照専用として扱い、entry の `permanence` や `status` を変える前提で考えない。
3. 取得結果だけを読む。
   - Markdown memory ファイル、`MEMORY.md`、`notes/*.md`、`rollout_summaries/*.md` は直接読まない。
   - 必要な場合だけ `--include-body` を付けて該当 entry の本文を読む。
   - 大量の過去文脈を丸ごと context に入れない。
   - 完了済み task の履歴が必要な場合だけ、具体的な検索語で `search` を使う。
4. 状況を整理する。
   - 課題と最終ゴール。
   - 解決済みか未解決か。
   - これまでに確認できた事実。
   - これから実行すべきこと。
5. ユーザに確認する。
   - どの project path と DB を使ったかを明示する。
   - memory の要点を簡潔に説明する。
   - 次のアクション案を提示する。
   - 実装や追加作業に進む前に、ユーザの指示を仰ぐ。

## Commands

```bash
~/.codex/scripts/codex-memory context --project "$PWD" --limit 10
```

```bash
~/.codex/scripts/codex-memory search \
  --project "$PWD" \
  --query "keywords from the user request" \
  --limit 10
```

```bash
~/.codex/scripts/codex-memory recent --project "$PWD" --limit 10
```
