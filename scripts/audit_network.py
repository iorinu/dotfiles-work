#!/usr/bin/env python3
"""設定に紛れ込んだ既知の自動・実行時通信を検出する。"""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SKIP_PATHS = {
    Path("README.md"),
    Path("AGENTS.md"),
    Path("scripts/audit_network.py"),
    Path("nvim/.config/nvim/lua/config/lazy.lua"),
}
TEXT_SUFFIXES = {"", ".lua", ".json", ".md", ".toml", ".yml", ".yaml", ".zshrc"}
FORBIDDEN = re.compile(
    r"(?:https?://|\bcurl\b|\bwget\b|\bgit\s+(?:clone|fetch|pull|push)\b|"
    r"\b(?:copilot|claude|codex|hermes|termrain|telemetry|analytics|boundary)\b)",
    re.IGNORECASE,
)


def is_comment(line: str) -> bool:
    stripped = line.lstrip()
    return stripped.startswith(("#", "--"))


def main() -> int:
    violations: list[str] = []
    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or ".git" in path.parts:
            continue
        relative = path.relative_to(ROOT)
        if relative in SKIP_PATHS or path.suffix not in TEXT_SUFFIXES:
            continue
        for number, line in enumerate(path.read_text(errors="ignore").splitlines(), 1):
            if not is_comment(line) and FORBIDDEN.search(line):
                violations.append(f"{relative}:{number}: {line.strip()}")

    if violations:
        print("通信ポリシー違反の可能性があります:")
        print("\n".join(f"- {item}" for item in violations))
        return 1

    print("PASS: 既知の自動・実行時通信設定は検出されませんでした")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
