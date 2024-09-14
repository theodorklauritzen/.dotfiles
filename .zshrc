

# Install Zinit - package manager for zsh
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias python="python3"
alias pip="pip3"

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Maven path, this should not be commited
export PATH="$PATH:/Users/theodorkvalsviklauritzen/Downloads/apache-maven-3.9.9/bin"

eval "$(starship init zsh)"

