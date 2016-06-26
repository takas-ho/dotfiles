# .bash_profileはログイン時にのみ実行
# .bashrcはbash起動の度に動く

#export SWIFTENV_ROOT="$HOME/.swiftenv"
#export PATH="$SWIFTENV_ROOT/bin:$PATH"
#eval "$(swiftenv init -)"


export SWIFT_BIN="/usr/local/toolchains/swift-current/usr/bin"
export SWIFT_LIB="/usr/local/toolchains/swift-current/usr/lib"

export PATH="${SWIFT_BIN}":"${PATH}"
export LD_LIBRARY_PATH="${SWIFT_LIB}":"${LD_LIBRARY_PATH}"
export LD_RUN_PATH="${SWIFT_LIB}":"${LD_RUN_PATH}"

export NVM_DIR="/home/takas-ho/.nvm"

export PATH="$HOME/.rbenv/bin:$PATH"
