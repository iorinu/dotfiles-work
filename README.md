# dotfiles-work

社内macOS端末向けのdotfilesです。GNU Stowで設定を配置します。

## 通信方針

- Homebrew、Neovimプラグイン、Treesitterパーサー、Mason管理のLSPを導入・更新するときの通信は許可します。
- AI連携、天気取得、テレメトリーなど、開発環境の導入・更新に不要な自動通信は設定に含めません。
- Copilot、Claude Code、Codex、Hermes、termrainの設定は含めません。

このリポジトリはアプリケーション設定による自動通信を抑えるものです。OSレベルで通信を遮断するものではありません。`git push`などを利用者が明示的に実行した場合や、導入済みアプリ本体の仕様による通信までは防止できません。厳密な遮断が必要な場合は、社内指定のファイアウォールも併用してください。

## セットアップ

必要なソフトウェアの導入時だけ、社内ルールに従って通信を許可します。

```sh
brew bundle --file=homebrew/Brewfile
```

配置前にdry-runします。

```sh
stow --no-folding --simulate --verbose=1 zsh git nvim wezterm
```

問題がなければ配置します。

```sh
stow --no-folding zsh git nvim wezterm
```

Neovimでは、lazy.nvim、各プラグイン、Treesitterパーサー、LSPの導入・更新時に通信が発生します。

## 監査

```sh
python3 scripts/audit_network.py
```

監査は既知の自動通信設定や通信コマンドを検出する補助チェックです。完全な通信遮断を保証するものではありません。
