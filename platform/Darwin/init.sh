#!/usr/bin/env bash

echo "hello"

# https://brew.sh/index_ja.html
if [[ ! -f `which brew` ]];then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install library
brew install git \
    openssl \
    wget \
    rsync \
    gibo \
    direnv \
    watch \
    tree \
    zsh
