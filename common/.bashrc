# ~/.bashrc

# Exit early if not running interactively
case $- in
    *i*) ;;
      *) return;;
esac

# Shell Options & History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Friendly previewing for non-text files with less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Environment Variables & PATH
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

# External Files (Aliases & Functions)
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions ] && . ~/.bash_functions

# Prompt & Shell Utilities
eval "$(starship init bash)"
fastfetch
