[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/bin
export EDITOR="nvim"
export TERMINAL="urxvt"
export BROWSER="firefox"

export ACTIVE_SINK=0

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi

