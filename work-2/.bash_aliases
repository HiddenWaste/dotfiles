alias z='zellij'
alias t='echo $(timedatectl status | grep "Local" | tail -c 13 | head -c 9)'
alias h='history'

# some more ls aliases
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto --exclude-dir={.git,node_modules,venv,.venv,build,dist}'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias emptydir='rm -rf ./*'
# ^ this is to help prevent accidentally removing all files

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# updating
alias up='sudo apt update && sudo apt upgrade -y'
