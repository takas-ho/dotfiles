# .bash_profileはログイン時にのみ実行
# .bashrcはbash起動の度に動く

#export SWIFTENV_ROOT="$HOME/.swiftenv"
#export PATH="$SWIFTENV_ROOT/bin:$PATH"
#eval "$(swiftenv init -)"

if [ "$(uname)" == 'Linux' ]; then
	# linuxならswift追記
	export SWIFT_BIN="/usr/local/toolchains/swift-current/usr/bin"
	export SWIFT_LIB="/usr/local/toolchains/swift-current/usr/lib"

	export PATH="${SWIFT_BIN}":"${PATH}"
	export LD_LIBRARY_PATH="${SWIFT_LIB}":"${LD_LIBRARY_PATH}"
	export LD_RUN_PATH="${SWIFT_LIB}":"${LD_RUN_PATH}"
fi

export NVM_DIR="$HOME/.nvm"

if [ "$(uname)" == "Linux" ]; then
	export RBENV_BIN="$HOME/.rbenv/bin"
	export PATH="$RBENV_BIN:$PATH"
fi

export PATH="$HOME/bin:$PATH"

if [ "$(uname)" == 'Darwin' ]; then
	# Mac
	source "$HOME/.bashrc"
fi
