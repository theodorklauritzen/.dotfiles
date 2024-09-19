alias python=python3
alias pip=pip3

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

autoload -U colors && colors
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%1~%{$reset_color%} %% "

export PATH="./node_modules/.bin:/Users/theodorkl/Documents/javacc-javacc-7.0.13/scripts:/usr/local/opt/node@20/bin:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home

autoload -Uz compinit && compinit

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
