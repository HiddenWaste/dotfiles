alias z='zellij'
alias t='echo $(timedatectl status | grep "Local" | tail -c 13 | head -c 9)'
alias h='history'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias emptydir='rm -rf ./*'
# ^ this is to help prevent accidentally removing all files
