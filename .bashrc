# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color'
alias notes='vim ~/notes'
PS1='\033[92m\u\033[0m@\033[96m\h\033[0m \033[33m\w\033[0m (\033[95m`gitbranch`\033[0m)\n\$ '
