function is_ssh_session
    set pid $fish_pid
    while test $pid -gt 1
        set pid (string trim (ps o ppid= -p $pid))
        set cmdline (awk -F'\x00' '{print $1}' "/proc/$pid/cmdline")
        echo $cmdline | grep ssh >/dev/null && return 0
        echo $cmdline | grep kitty >/dev/null && return 1
    end
    return 1
end

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

    set -l dur $CMD_DURATION
    if [ $dur -ge 1000 ]
        set_color red
        printf "took %.0fs " (math $dur / 1000)
    else if [ $dur -ge 100 ]
        set_color yellow
        printf "took %.0fms " (math $dur)
    end

    if is_ssh_session
        set_color brred
        printf "[%s] " (hostname)
    end

    if [ -n "$hacking" ]
        set_color brred
    else
        set_color brcyan
    end
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
    if [ -f ~/.cache/tldmsg ]
        cat ~/.cache/tldmsg
    end
end

alias e nvim
alias lg lazygit
alias ip "ip -c"

function ns
    nix shell nixpkgs#$argv
end

function nsu
    nix shell unstable#$argv
end

function fhs
    nix run --impure --expr \
        "let pkgs = import <nixpkgs> {}; in pkgs.buildFHSUserEnv { name = ''fhs-user-env''; targetPkgs = p: with p; [fish $argv]; runScript = ''fish''; }"
end
