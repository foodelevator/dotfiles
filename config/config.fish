function fish_prompt
    set s $status
    if [ $s != "0" ]
        set_color normal
        printf "["
        set_color red
        printf "$s"
        set_color normal
        printf "] "
    end
	set_color green
	printf "%s" (whoami)
	set_color normal
	printf "@"
	set_color cyan
	printf "%s " (cat /etc/hostname)
	set_color yellow
	printf "%s " (prompt_pwd)
	set_color bryellow
	printf "%s" (git branch 2>/dev/null | sed -rn '/\* /s/(\* )(.*)/(\2)/p')
	set_color normal
	printf "\n\$ "
end

function fish_greeting
end

alias e nvim
abbr nvim cringe
