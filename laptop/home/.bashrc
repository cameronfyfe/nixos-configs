# stateful and/or private bashrc files
. ~/.bashrc-*

# nixos treason - add /bin/bash
if [[ ! -L /bin/bash ]]; then
	sudo ln -s /run/current-system/sw/bin/bash /bin/bash >/dev/null 2>&1 || true
fi

# --- helpers ---
alias inix='echo $IN_NIX_SHELL'
alias docker-clean='docker rm -vf $(docker ps -a -q); docker rmi -f $(docker images -a -q)'
alias data-hogs='sudo du -a / | sort -n -r | head -40'
alias rchmod="stat --format '%a'"

# --- common docker environments ---
alias debian='docker run --rm -it -v $(pwd):/c -w="/c" debian:latest bash'
alias ubuntu='docker run --rm -it -v $(pwd):/c -w="/c" ubuntu:latest bash'
alias alpine='docker run --rm -it -v $(pwd):/c -w="/c" alpine:latest ash'

function repeat() {
	while true; do $@; sleep 1; done
}
export -f repeat

# --- aliases
alias vim='nvim'
