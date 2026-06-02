#!/usr/bin/env python3
import json
import shlex
import sys
from pathlib import Path


SHELL_METACHARACTERS = set("|&;><`()$*?")


def load_policy() -> dict:
    policy_path = Path(__file__).with_name("auto_approve_policy.json")
    return json.loads(policy_path.read_text())


def tokenize(command: str) -> list[str] | None:
    try:
        return shlex.split(command, posix=True)
    except ValueError:
        return None


def has_shell_metacharacters(command: str) -> bool:
    return any(ch in SHELL_METACHARACTERS for ch in command)


def parse_prefixes(values: list[str]) -> list[list[str]]:
    prefixes: list[list[str]] = []
    for value in values:
        tokens = tokenize(value)
        if tokens:
            prefixes.append(tokens)
    return prefixes


def starts_with(tokens: list[str], prefix: list[str]) -> bool:
    return len(tokens) >= len(prefix) and tokens[: len(prefix)] == prefix


def emit_allow() -> None:
    print(
        json.dumps(
            {
                "hookSpecificOutput": {
                    "hookEventName": "PermissionRequest",
                    "decision": {
                        "behavior": "allow",
                    },
                }
            }
        )
    )


def emit_deny(message: str) -> None:
    print(
        json.dumps(
            {
                "hookSpecificOutput": {
                    "hookEventName": "PermissionRequest",
                    "decision": {
                        "behavior": "deny",
                        "message": message,
                    },
                }
            }
        )
    )


def main() -> int:
    event = json.load(sys.stdin)
    if event.get("hook_event_name") != "PermissionRequest":
        return 0
    if event.get("tool_name") != "Bash":
        return 0

    command = (event.get("tool_input") or {}).get("command")
    if not isinstance(command, str) or not command.strip():
        return 0

    policy = load_policy()
    if policy.get("options", {}).get("reject_if_contains_shell_metacharacters", True):
        if has_shell_metacharacters(command):
            return 0

    tokens = tokenize(command)
    if not tokens:
        return 0

    bash_policy = policy.get("bash", {})
    deny_prefixes = parse_prefixes(bash_policy.get("deny_prefixes", []))
    for prefix in deny_prefixes:
        if starts_with(tokens, prefix):
            emit_deny(f"Blocked by global auto-approval deny list: {' '.join(prefix)}")
            return 0

    permission_mode = event.get("permission_mode") or ""
    allow_by_mode = bash_policy.get("allow_by_mode", {})
    allowed_prefixes = parse_prefixes(allow_by_mode.get(permission_mode, []))
    for prefix in allowed_prefixes:
        if starts_with(tokens, prefix):
            emit_allow()
            return 0

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
