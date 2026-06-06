# Detect if running directly vs sourced
if [[ "$ZSH_EVAL_CONTEXT" == "toplevel" ]]; then
  DOTPATH="${HOME}/dotfiles"
fi

mkdir -p "${HOME}/.config/mise"
ln -sf ${DOTPATH}/mise/mise.toml ${HOME}/.config/mise/config.toml
mise install
