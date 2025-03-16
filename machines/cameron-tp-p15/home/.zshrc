# oh-my-zsh theme
ZSH_THEME="af-magic" 

HISTFILE=~/.zsh_history_$(date +%Y-%m-%d_%H-%M-%S)
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/cameron/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# stateful and/or private zshrc files
for rc_file in ~/.zshrc-*; do
  [[ -r "$rc_file" ]] && source "$rc_file"
done

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

docker-clean() {
  docker rm -vf $(docker ps -a -q)
  docker rmi -f $(docker images -a -q)
  docker system prune -a
}

# --- computer helpers ---
alias hdmi-wakeup='xrandr --output HDMI-1-3 --left-of eDP-1 --auto'

# --- common docker environments ---
alias debian='docker run --rm -it -v $(pwd):/c -w="/c" debian:latest bash'
alias ubuntu='docker run --rm -it -v $(pwd):/c -w="/c" ubuntu:latest bash'
alias alpine='docker run --rm -it -v $(pwd):/c -w="/c" alpine:latest ash'
alias nixos='docker run --rm -it -v $(pwd):/c -w="/c" nix-flakes:latest sh'
alias rust='docker run --rm -it -v $(pwd):/c -w="/c" rust:bullseye bash'

# --- dev editor ---
alias set-vim='export OPEN_EDITOR_CMD="xterm -e nvim"'
alias set-codium='export OPEN_EDITOR_CMD=codium'
alias set-none='export OPEN_EDITOR_CMD=""'

# --- short cuts ---
alias v='nvim'
alias c='codium'

# --- git shortcuts
alias guc='git reset --soft HEAD~1'

# --- terminal helpers ---
alias _='new_term'
alias _nvim='_ nvim'
alias _htop='_ htop'
alias _nload='_ nload'

# --- terminal helpers ---
alias i_wd='echo "cd -P /proc/$$/cwd" | xsel -i'
alias o_wd='$(xsel -o)'

new_term() {
	xterm -e "$@" > /dev/null 2>&1 &
}

# repeat() {
# 	while true; do $@; sleep 1; done
# }
