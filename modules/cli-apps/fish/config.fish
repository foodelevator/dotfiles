function fish_prompt
    set -l dur $CMD_DURATION
    if [ $dur -ge 1000 ]
        set_color red
        printf "took %.0fs " (math $dur / 1000)
    end

    set_color brcyan
    printf "%s " (date +"%H:%M:%S")

    set cwd (pwd)
    if [ "$cwd" = "$HOME" ]
        set cwd "~"
    else
        set cwd (basename $cwd)
    end
    set_color yellow
    printf "%s " $cwd

	set_color bryellow
	printf "%s" (git branch 2>/dev/null | sed -rn '/\* /s/(\* )(.*)/(\2) /p')

    set_color normal
end

function fish_greeting
end

alias e nvim
