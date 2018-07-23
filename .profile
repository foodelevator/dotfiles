[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:$HOME/bin
export EDITOR="vim"
export TERMINAL="urxvt"
export BROWSER="firefox"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi

