# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh/"
export VISUAL="subl"
export DOTPATH="${HOME}/dotfiles"
export LOCAL_EXPORTS="${HOME}/.exports.sh"
export LOCAL_ALIASES="${HOME}/.aliases.sh"
export LOCAL_FUNCTIONS="${HOME}/.functions.sh"

HIST_STAMPS="yyyy-mm-dd"

fpath=(~/.completions/ $fpath)

# only load plugins if interactive shell
if [[ -t 1 ]] then
    plugins=(
        git
        git-extras    
        gh
        macos
        terraform
        direnv
        1password
    )

    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

    source $ZSH/oh-my-zsh.sh
fi



# Shared Aliases/Exports
DOTPATH_ZSH=${DOTPATH}/setups/zsh
source ${DOTPATH_ZSH}/aliases.sh
source ${DOTPATH_ZSH}/exports.sh
source ${DOTPATH_ZSH}/functions.sh

if [[ -t 1 ]] && command -v op &>/dev/null; then
  eval "$(op completion zsh)"
  compdef _op op
fi

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

# Setup fzf config
source <(fzf --zsh)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
