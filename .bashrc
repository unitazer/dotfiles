#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fucking="sudo"
alias neofetch="fastfetch"

eval "$(zoxide init bash)"
eval "$(starship init bash)"
