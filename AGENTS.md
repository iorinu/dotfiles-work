# AGENTS.md

## 目的

このリポジトリは、社内macOS端末向けのdotfilesを管理します。

## 通信ポリシー

- ソフトウェア、Neovimプラグイン、Treesitterパーサー、LSPの導入・更新に必要な外部通信は許可する。
- テレメトリー送信、AI API呼び出し、天気取得など、開発環境の導入・更新に不要な自動通信は追加しない。
- 通信する機能を追加する場合は、通信先、タイミング、送信内容を確認してから変更する。
- 認証情報、トークン、秘密鍵、`.env`は管理しない。

## 変更と検証

変更後は次を実行する。

```sh
python3 scripts/audit_network.py
stow --no-folding --simulate --verbose=1 zsh git nvim wezterm
git diff --check
git status --short
```

LuaまたはZshを変更した場合は構文チェックも行う。
