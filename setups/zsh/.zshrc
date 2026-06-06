# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh/"
export VISUAL="subl"
export DOTFILES_DIR="${HOME}/dotfiles"
export LOCAL_EXPORTS="${HOME}/.local_exports"
export LOCAL_ALIASES="${HOME}/.local_aliases"

HIST_STAMPS="yyyy-mm-dd"

fpath=(~/.completions/ $fpath)

plugins=(
    git
    git-extras    
    gh
    macos
    1password
    terraform
    direnv
)

FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

source $ZSH/oh-my-zsh.sh

# Shared Aliases/Exports
source $DOTFILES_DIR/.aliases
source $DOTFILES_DIR/.exports
source $DOTFILES_DIR/.functions

# Local Aliases/Exports
if [ -f $LOCAL_EXPORTS ]; then
    source $LOCAL_EXPORTS
fi

if [ -f $LOCAL_ALIASES ]; then
    source $LOCAL_ALIASES
fi

# Setup fzf config
source <(fzf --zsh)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
