eval "$(fasd --init auto)"
autoload -U promptinit && promptinit
alias v='f -e vim'
alias nix-search='nix-env -qaP | grep'
