#!/usr/bin/env bash
DOTPATH=${DOTPATH:-$HOME/dotfiles}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "== Installing Spaceship Prompt"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
chsh -s $(which zsh)
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

ln -s ${DOTPATH}/setups/zsh/.zshrc  ${HOME}/.zshrc
ln -s ${DOTPATH}/setups/zsh/.zprofile  ${HOME}/.zprofile
ln -s ${DOTPATH}/setups/zsh/.zshenv  ${HOME}/.zshenv
