# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

# エディタ
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Homebrewで導入済みのコマンドをPATHへ追加するだけで、更新確認は行わない
if [[ -x /opt/homebrew/bin/brew ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ローカルのツール用PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
export PATH="$HOME/go/bin:$PATH"

# 補完
fpath=("$HOME/.zfunc" $fpath)
autoload -Uz compinit
compinit

# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# ghq配下の社内PC向けdotfilesを操作するエイリアス
alias dotfiles='git -C "$HOME/src/github.com/iorinu/dotfiles-work"'
alias ll='ls -lhA'

# zoxideはローカルの移動履歴だけを利用する
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi
