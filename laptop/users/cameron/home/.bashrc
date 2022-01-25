# stateful and/or private bashrc files
. ~/.bashrc-*

# nixos treason - add /bin/bash
if [[ ! -L /bin/bash ]]; then
	sudo ln -s /run/current-system/sw/bin/bash /bin/bash >/dev/null 2>&1 || true
fi

# --- helpers ---
alias docker_clean='docker rm -vf $(docker ps -a -q); docker rmi -f $(docker images -a -q)'

alias inix='echo $IN_NIX_SHELL'

function repeat() {
	while true; do $@; sleep 1; done
}
export -f repeat

# --- aliases
alias vim='nvim'
