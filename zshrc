# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export GIT_MERGE_AUTOEDIT=no

# zsh-completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# git-prompt
if [ -e ~/.zsh/git-prompt.sh ]; then
  # git-promptの読み込み
  source ~/.zsh/git-prompt.sh

  # git-completionの読み込み
  fpath=(~/.zsh $fpath)
  zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
  autoload -Uz compinit && compinit

  # プロンプトのオプション表示設定
  GIT_PS1_SHOWDIRTYSTATE=true

  setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f:%F{yellow}%~%f %F{cyan}$(__git_ps1 "(%s)")%f %F{blue}%%%f '
fi

if type brew &>/dev/null; then
  # MacVim
  if [ -e $(brew --prefix)/bin/mvim ]; then
    export EDITOR=$(brew --prefix)/bin/mvim
    alias mvimnew=$(brew --prefix)/bin/mvim
    alias mvim="mvimnew --remote-tab-silent"
    alias gvimnew=mvimnew
    alias gvim=mvim
  fi
fi

