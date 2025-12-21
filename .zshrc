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
    1password
    terraform
    direnv
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

export PATH=$SPARK_HOME/bin:/Users/jacobo.blanco/.local/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

# opencode
export PATH=/Users/jacobo.blanco/.opencode/bin:$PATH
