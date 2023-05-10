EDITOR=/usr/bin/vim
PS1="\n\[\e[1;49;31m\]$ \[\e[1;49;35m\]"
# trap to separate colors from PS1 and output
trap '[[ -t 1 ]] && tput sgr0' DEBUG

alias g='grep'
alias h='history | grep -v " h "| grep'
alias today='date +%Y%m%d'
alias systemupdate='sudo dnf update && sudo flatpak update'
alias fn='sudo echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode'
source <(oc completion bash)
source <(kubectl completion bash)
