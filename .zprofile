
# Setting PATH for Python 3.11
# And added visual studio code
# The original version is saved in .zprofile.pysave
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"

if [ "$(hostname)" = "theodor-HP-PC" ]; then
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
fi

alias python="python3"
alias pip="pip3"

# Check if the system is MacOS
if [ "$(uname)" = "Darwin" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ "$(hostname)" = "Theodors-MacBook-Pro.local" ]; then
    export GOPATH="/Users/theodorkvalsviklauritzen/Documents/programming/go"

    # Bison 3.8 instead of 2.3, used for the course TDT4205
    export PATH="$(brew --prefix)/opt/bison/bin:$PATH"
fi
