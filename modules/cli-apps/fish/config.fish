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
    set last (date +%s -r ~/.cache/tldlist 2>/dev/null || echo 0)
    if [ (math "$(date +%s)" - $last) -gt 80000 ]
        curl https://data.iana.org/TLD/tlds-alpha-by-domain.txt -o ~/.cache/tldlist.tmp -s || return
        mv ~/.cache/tldlist.tmp ~/.cache/tldlist
    end

    awk 'tolower($0)~/^on$|^son$|^sson$/{print "TLD:n ."$0" finns!!!"}' ~/.cache/tldlist
end

alias e nvim
alias lg lazygit

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
