# Path stuff
path+=("/home/adi/DEV/flutter/bin")
path+=("/home/adi/.spicetify")
path+=("/home/adi/.local/share/JetBrains/Toolbox/scripts")
path+=("/home/adi/go/bin")
path+=("/opt/git-fuzzy/bin")
path+=("/home/adi/.fzf/bin")
path+=("/home/adi/.local/bin")
path+=("/home/adi/.local/nvim/bin")

# Env stuff
export PATH
export ELECTRON_OZONE_PLATFORM_HINT=auto
export MICRO_TRUECOLOR=1
export MICRO_CONFIG_HOME=$HOME/.config/micro
export SAL_USE_VCLPLUGIN=gtk3
export ZSH="$HOME/.oh-my-zsh"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# ZSH History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=15000
export SAVEHIST=50000
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_expire_dups_first

ZSH_THEME="robbyrussell"

plugins=(
    ssh-agent
	zsh-nvm
)

# Load OhMyZsh
source $ZSH/oh-my-zsh.sh

# Loading syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Loading Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

### Aliases ###

# General
alias mi="micro"
alias dnf-update="sudo dnf update --refresh"
alias run-backup="sh $HOME/Documents/Tools/backup.sh"
alias ltr="ls -latr"
alias gf="git fuzzy"

# Git
alias gst="git status"
alias gp="git push"
alias gadd="git add"
alias gc="git commit -m"
alias gprune="git fetch -p && git branch --merged | grep -v '*' | grep -v 'main' | xargs git branch -d"

# FZF
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

### Functions ###

# fsearch - Search with FZF
function fsearch() {
	fzf --preview 'bat --color=always {}'
}

function fvim() {
	local file=$(fzf --preview 'bat --color=always {}')
	if [[ -n "$file" ]]; then
		nvim "$file"
	fi
}

# fmicro - Search and open with FZF/Micro
function fmicro() {
	local file=$(fzf --preview 'bat --color=always {}')
	if [[ -n "$file" ]]; then
		micro "$file"
	fi
}

# fbr - Switch to local or remote branch
function fbr() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    branch=$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")

    # Try to switch to the branch using git switch
    if git switch "$branch" 2>/dev/null; then
        return
    elif git switch -t "$branch" 2>/dev/null; then
        return
    fi
}

# fcommit - Commit browser with previews
function fcommit() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fda - Change into directories including hidden directories
function fcd() {
  local dir
  dir=$(find ${2:-.} -type d 2> /dev/null | fzf +m)

  if [[ -n "$dir" ]]; then
      folder_name=$(basename "$dir")
      cd "$dir"

      if [[ "$1" == "vim" ]]; then
          if [[ -d ".git" ]]; then 
              kitty @ launch --type=tab --tab-title="lazygit: $folder_name" --keep-focus --cwd="$(pwd)" lazygit
          fi

          kitty @ set-tab-title "nvim: $folder_name"
          nvim
      fi
  fi
}

# fkill - Kill a process
function fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# ds - Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# drm - Select a running docker container to remove, multi-select enabled
function drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}

# drmi - Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
