# stateful and/or private bashrc files
. ~/.bashrc-*

# nixos treason - add /bin/bash, etc
if [[ ! -L /bin/bash ]]; then
	sudo ln -s /run/current-system/sw/bin/bash /bin/bash >/dev/null 2>&1 || true
fi
if [[ ! -L /bin/stty ]]; then
	sudo ln -s /run/current-system/sw/bin/stty /bin/stty >/dev/null 2>&1 || true
fi

# --- general helpers ---
alias inix='echo $IN_NIX_SHELL'
alias data-hogs='sudo du -a / | sort -n -r | head -40'
alias rchmod="stat --format '%a'"
function docker-clean() {
	docker rm -vf $(docker ps -a -q)
	docker rmi -f $(docker images -a -q)
	docker system prune -a
}
export -f docker-clean

# --- computer helpers ---
alias hdmi-wakeup='xrandr --output HDMI-1-3 --left-of eDP-1 --auto'

# --- common docker environments ---
alias debian='docker run --rm -it -v $(pwd):/c -w="/c" debian:latest bash'
alias ubuntu='docker run --rm -it -v $(pwd):/c -w="/c" ubuntu:latest bash'
alias alpine='docker run --rm -it -v $(pwd):/c -w="/c" alpine:latest ash'
alias nixos='docker run --rm -it -v $(pwd):/c -w="/c" nix-flakes:latest sh'

# --- dev editor ---
alias set-vim='export OPEN_EDITOR_CMD="xterm -e nvim"'
alias set-codium='export OPEN_EDITOR_CMD=codium'
alias set-none='export OPEN_EDITOR_CMD=""'

# --- short cuts ---
alias _='new_term'
alias _nvim='_ nvim'
alias _htop='_ htop'
alias _nload='_ nload'

# --- terminal helpers ---
alias i_wd='echo "cd -P /proc/$$/cwd" | xsel -i'
alias o_wd='$(xsel -o)'

function new_term() {
	xterm -e "$@" > /dev/null 2>&1 &
}
export -f repeat

function repeat() {
	while true; do $@; sleep 1; done
}
export -f repeat
