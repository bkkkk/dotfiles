# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh/"
export VISUAL="subl"

HIST_STAMPS="yyyy-mm-dd"

fpath=(~/.completions/ $fpath)

plugins=(
    git
    git-extras    
    gh
    macos
    poetry
    1password
    terraform
)

FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

source $ZSH/oh-my-zsh.sh

# Shared Aliases/Exports
source ~/.aliases
source ~/.exports
source ~/.functions

# Local Aliases/Exports
if [ -f ~/.local_exports ]; then
    source ~/.local_exports
fi

if [ -f ~/.local_aliases ]; then
    source ~/.local_aliases
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"