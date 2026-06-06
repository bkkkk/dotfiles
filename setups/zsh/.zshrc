# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh/"
export VISUAL="subl"
export DOTPATH="${HOME}/dotfiles"
export LOCAL_EXPORTS="${HOME}/.exports.local.sh"
export LOCAL_ALIASES="${HOME}/.aliases.local.sh"
export LOCAL_FUNCTIONS="${HOME}/.functions.local.sh"

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
DOTPATH_ZSH=${DOTPATH}/setups/zsh
source ${DOTPATH_ZSH}/aliases.sh
source ${DOTPATH_ZSH}/exports.sh
source ${DOTPATH_ZSH}/functions.sh

# Local Aliases/Exports
if [ -f $LOCAL_EXPORTS ]; then
    source $LOCAL_EXPORTS
fi

if [ -f $LOCAL_ALIASES ]; then
    source $LOCAL_ALIASES
fi

if [ -f $LOCAL_FUNCTIONS ]; then
    source $LOCAL_FUNCTIONS
fi

eval "$(mise activate zsh)"

# Setup fzf config
source <(fzf --zsh)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
