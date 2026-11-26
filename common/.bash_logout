#
# ~/.bash_logout
#

# forget cached sudo credentials
command -v sudo >/dev/null && sudo -k

# clear the screen when leaving a text console
[ "$SHLVL" = 1 ] && command -v clear >/dev/null && clear
