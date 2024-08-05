
PROMPT="%F{46}theodor@%f%F{33}%~%f$ "

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz compinit && compinit

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

alias python="python3"
alias pip="pip3"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
