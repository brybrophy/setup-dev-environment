export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="sobol"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias gbra="git branch | grep -v "master" | grep -v "main" | grep -v "develop" | xargs git branch -D"
alias gcm="git co main"
alias gc="git co"
alias gpl="git pull origin HEAD"
alias gps="git push origin HEAD"
alias gpf="git push origin HEAD --force --no-verify"
alias gs="git stash"
alias gsa="git stash apply"

export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate zsh)"
