#!/usr/bin/env bash

echo "== Welcome! Setting up standard Jacob environment =="

echo "== Installing Command Line Tools =="
xcode-select --install

echo "== Installing Homebrew =="

if ! which brew > /dev/null; then
     # Install Homebrew 
     /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

brew update

echo "== Installing applications in Brewfile =="
brew bundle

echo "== Setting up Shell Config =="
source zsh/install.sh
stow zsh

echo "== Setting up git configuration =="
stow git

echo "== Setting up MacOS defaults configuration =="
source .macos
