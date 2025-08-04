#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# sourcing blesh to replace readline in bash, we also need one line that is at ther end of this file
# [[ $- == *i* ]] && source -- /usr/share/blesh/ble.sh --attach=none

# adding fzf suport (it should be added like this to get better integration with ble.sh
# ble-import  integration/fzf-completion
# ble-import  integration/fzf-key-bindings
eval "$(fzf --bash)"

# fzf preview options
export FZF_CTRL_T_OPTS="
  --height 60% \
  --border \
  --layout=reverse \
  --preview 'bat --style=numbers --color=always --line-range :500 {}' \
  --preview-window='right:60%'  
"

# (Optionally) preview directory tree when using ALT-C
export FZF_ALT_C_OPTS="
  --preview 'tree -C {} | head -200' \
  --preview-window='right:50%'  
"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

### meus alias
alias ..='cd ..'
alias ...='cd ../..'

# finishing to setup blesh
# [[ ! ${BLE_VERSION-} ]] || ble-attach
alias run-hyro-docker="/home/ielson/docker/hyro_docker/scripts/run.sh"
alias kill-hyro-docker="docker compose -f /home/ielson/docker/hyro_docker/scripts/docker-compose.yml down"

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
