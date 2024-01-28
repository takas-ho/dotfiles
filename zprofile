eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"

export PATH="$HOME/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

function conv-mov-to-mp4(){
    ffmpeg -i $1 -vf w3fdif -pix_fmt yuv420p ${1%.*}.mp4
}
function conv-2017-mov-to-mp4(){
    ffmpeg -i /Volumes/takas-ho/tmp/$1 -vf w3fdif -pix_fmt yuv420p ~/tmp/${1%.*}.mp4
}
