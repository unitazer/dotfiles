#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fucking="sudo"
alias neofetch="fastfetch"

PS1='[\u@\h \W]\$ '
eval "$(zoxide init bash)"
eval "$(starship init bash)"


export PATH=$PATH:/home/unitazer/.spicetify
