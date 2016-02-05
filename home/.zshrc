source "$HOME/.slimzsh/slim.zsh"
eval "$(fasd -- init auto)"
autoload -U promptinit && promptinit
alias v='f -e vim'
alias nix-search='nix-env -qaP | grep'
PURE_PROMPT_SYMBOL=">"
prompt pure
