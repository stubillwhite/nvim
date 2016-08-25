#!/bin/zsh

setopt EXTENDED_GLOB

FILES=(
    "init.vim"
)

INSTALLATION_DIR=$HOME/.config/nvim

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

mkdir -p $INSTALLATION_DIR

for FILE in "${FILES[@]}"
do
    HOME_FILE="$INSTALLATION_DIR/`basename $FILE`"
    echo Creating link $HOME_FILE
    rm -f $HOME_FILE 2> /dev/null || true
    ln -s `realpath $FILE` $HOME_FILE
done

PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo Downloading $PLUG_URL
curl -fLo $INSTALLATION_DIR/autoload/plug.vim --create-dirs $PLUG_URL
