# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_MERGE_AUTOEDIT=no

# MacVim
if [ "$(uname)" = "Darwin" ]; then
	export EDITOR=/usr/local/bin/mvim
	alias mvimnew=/usr/local/bin/mvim
	alias mvim="mvimnew --remote-tab-silent"
	alias gvimnew=mvimnew
	alias gvim=mvim
fi

