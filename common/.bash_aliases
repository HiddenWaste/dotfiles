alias z='zellij'
alias t='echo $(timedatectl status | grep "Local" | tail -c 13 | head -c 9)'
alias h='history'
alias v='vim'

############
# LS STUFF #
############
# = {{{
unset LS_OPTIONS # Reset Env Variable

# Safely initialize system default colors
if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
fi
# di = bold blue (still uses theme's blue slot)
# ln = bold true-color RGB magenta (#FF00FF)
export LS_COLORS="ln=target:di=01;34:ln=38;2;255;0;255;1:"
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# }}}

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias emptydir='rm -rf ./*'
# ^ this is to help prevent accidentally removing all files

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
