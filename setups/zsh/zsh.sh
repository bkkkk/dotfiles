#!/usr/bin/env bash
DOTPATH=${DOTPATH:-$HOME/dotfiles}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ln -s ${DOTPATH}/setups/zsh/.zshrc  ${HOME}/.zshrc
ln -s ${DOTPATH}/setups/zsh/.zprofile  ${HOME}/.zprofile
ln -s ${DOTPATH}/setups/zsh/.zshenv  ${HOME}/.zshenv
