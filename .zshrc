# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh/"
export VISUAL="subl -w"

HIST_STAMPS="yyyy-mm-dd"
ZSH_THEME="spaceship"

fpath=(~/.completions/ $fpath)

plugins=(
    docker
    docker-compose
    z
    git
    git-extras
    macos
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

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "/Users/jacoboblanco/.ghcup/env" ] && source "/Users/jacoboblanco/.ghcup/env" # ghcup-env

git_main_branch () {
    command git rev-parse --git-dir &> /dev/null || return
    local ref
    for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}
    do
        if command git show-ref -q --verify $ref
        then
            echo ${ref:t}
            return
        fi
    done
    echo master
}
