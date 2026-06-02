# Codex auto-approve proposal

As of 2026-06-02, Codex has two official mechanisms that cover most of the
"Claude Code hooks style auto approval" use cases.

## 1. Use `rules` first for fixed command prefixes

If the requirement is:

- "Always allow this exact command prefix"
- "Always prompt for this prefix"
- "Never allow this prefix"

then `rules` are the better primitive than a custom script.

Why:

- official support for outside-sandbox command control
- exact prefix matching
- can test with `codex execpolicy check`
- Codex can split simple compound shell commands and evaluate each segment

Examples:

- `git status`
- `git diff`
- `git log`

This repo now includes a sample rules file:

- `codex/rules/default.rules`

## 2. Use `PermissionRequest` hooks for dynamic logic

If the requirement is:

- "Auto-allow only if the command matches a local allowlist"
- "Auto-deny some prefixes"
- "Skip compound commands, redirection, globs, or variable expansion"
- "Keep normal approval UI for everything else"

then a `PermissionRequest` hook is the better fit.

This repo now includes:

- `codex/hooks.json`
- `codex/hooks/permission_request_auto_allow.py`
- `codex/hooks/auto_approve_policy.json`

Current behavior:

- only handles `Bash` approval requests
- leaves `git status` and `git diff` to `rules`
- auto-allows selected command prefixes only in strong permission modes
- auto-denies a few clearly dangerous prefixes
- falls back to normal approval for anything else
- refuses to auto-allow commands containing shell metacharacters

## Recommended operating model

1. Put stable, deterministic command prefixes in `rules`.
2. Use `PermissionRequest` hooks only for logic that `rules` cannot express.
3. Keep the allowlist narrow.
4. Default to "no decision" for anything ambiguous.
5. Test rules with `codex execpolicy check`.
6. Review hook trust with `/hooks` before relying on project-local hooks.

## Important limitations

- Non-managed hooks must be trusted before Codex runs them.
- `PermissionRequest` hooks only run when approval is actually needed.
- `PreToolUse` / `PostToolUse` do not intercept every shell path yet.
- A hook can tighten policy safely, but broad auto-allow rules are risky.

## Suggested next changes

- add team-specific prefixes to `codex/rules/default.rules`
- extend `auto_approve_policy.json` with exact approved commands
- add a small audit log from the hook if you want traceability
- adjust `codex/hooks/auto_approve_policy.json` as your global policy

## Permission mode notes

The official hook docs list these `permission_mode` values:

- `default`
- `acceptEdits`
- `plan`
- `dontAsk`
- `bypassPermissions`

With the current `/permissions` menu shown in this environment, the practical
mapping appears to be:

- `Default` -> `default`
- `Auto-review` -> same workspace boundary as `Default`, so the hook likely
  still sees `default`
- `Full Access` -> `bypassPermissions`

That means a `PermissionRequest` hook can reliably branch on `default`,
`plan`, and `bypassPermissions`. `Auto-review` is a reviewer choice, not a
separate permission boundary.

## Sources

- OpenAI Codex Hooks:
  https://developers.openai.com/codex/hooks
- OpenAI Codex Rules:
  https://developers.openai.com/codex/rules
- OpenAI Codex Config Reference:
  https://developers.openai.com/codex/config-reference
- OpenAI Codex Advanced Config:
  https://developers.openai.com/codex/config-advanced
- OpenAI Codex Agent approvals & security:
  https://developers.openai.com/codex/agent-approvals-security
- Claude Code hooks guide:
  https://code.claude.com/docs/en/hooks-guide
