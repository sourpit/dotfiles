# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
  # Shell is non-interactive.  Be done now!
  return
fi

if [ -f "$XDG_CONFIG_HOME/bash-git-prompt/gitprompt.sh" ]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$XDG_CONFIG_HOME/bash-git-prompt/gitprompt.sh"
fi
GIT_PROMPT_THEME=Multi_line_NoExitState_Gentoo

# vim mode
set -o vi

# Improved cd
source ~/.local/bin/commacd.sh
eval "$(lua $XDG_DATA_HOME/z.lua/z.lua --init bash enhanced once)"
source -- ~/.local/share/blesh/ble.sh

osc7_cwd() {
  local strlen=${#PWD}
  local encoded=""
  local pos c o
  for ((pos = 0; pos < strlen; pos++)); do
    c=${PWD:$pos:1}
    case "$c" in
    [-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
    *) printf -v o '%%%02X' "'${c}" ;;
    esac
    encoded+="${o}"
  done
  printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd

# Jumping between prompts
# for default keybinds
# Ctrl + Shift + z or Ctrl + Shift + x
prompt_marker() {
  printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker

# Piping last command's output
PS0+='\e]133;C\e\\'

command_done() {
  printf '\e]133;D\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }command_done

# Put your fun stuff here.
alias \
  mvi="mpv --config-dir=$HOME/.config/mvi" \
  ipget='echo "$(curl ipinfo.io/ip --no-progress-bar --no-progress-meter)"' \
  wd='wget --recursive --level inf --relative --no-parent --tries 10 --continue --timestamping' \
  ud='curl --retry 10 --continue-at --remote-time --remote-name-all' \
  b="WD=\$(pwd);cd ~/Backup/Books;zathura \"\$(fzf)\";cd \$WD" \
  ds='du -akh | sort -rn | less' \
  ssh='dbclient' \
  i2pd='LD_PRELOAD=/usr/lib/libz.so i2pd'


# Abbreviate some stuff for the sake of learning
alias npm='pnpm'

# Verbosity and settings that you pretty much just always are going to want.
alias \
  cp="cp -iv" \
  mv="mv -iv" \
  rm="rm -vI" \
  bc="bc -ql" \
  rsync="rsync -vrPlu" \
  mkd="mkdir -pv" \
  yt="yt-dlp --embed-metadata -i" \
  yta="yt -x -f bestaudio/best" \
  ytt="yt --skip-download --write-thumbnail" \
  ffmpeg="ffmpeg -hide_banner"

# Colorize commands when possible.
alias \
  grep="grep --color=auto" \
  diff="diff --color=auto" \
  ccat="highlight --out-format=ansi" \
  l="ls -lahvF --color --group-directories-first --time-style=long-iso" \
  ip="ip -color=auto"

# Completion for doas
complete -cf doas

# sudo not required for some system commands
for command in emerge porttail emaint dispatch-conf mount umount shutdown poweroff reboot; do
  alias $command="doas $command"
done
unset command

# Cute anime gril notifying you after emerge finished
e() {
  doas emerge "$@" && setsid mpv --no-config ~/.config/mako/SFX/onii-chan.wav &>/dev/null || setsid mpv --no-config ~/.config/mako/SFX/onii-chan.wav &>/dev/null
}

mk() {
  cd "$1" || mkdir -p "$1" && cd "$1"
}

# vim into directory
vd() {
  if [ -d "$1" ]; then
    cd "$1"
  elif [ -f "$1" ]; then
    cd "$(dirname "$1")" && vi "$(basename "$1")"
  else
    echo "No such file or directory: $1"
  fi
}

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

bind -x '"\C-f": "BUFFER=$(FZF-FILE-SEARCH); READLINE_LINE=${READLINE_LINE:0:READLINE_POINT}${BUFFER}${READLINE_LINE:READLINE_POINT}; READLINE_POINT=$((READLINE_POINT + ${#BUFFER}))"'
bind -x '"\C-p": "BUFFER=$(FZF-DIR-SEARCH); READLINE_LINE=${READLINE_LINE:0:READLINE_POINT}${BUFFER}${READLINE_LINE:READLINE_POINT}; READLINE_POINT=$((READLINE_POINT + ${#BUFFER}))"'

FZF-FILE-SEARCH() {
ls -Ah --group-directories-first --color=always | fzf --reverse -m --ansi --height=50% --border=bold --prompt "$(pwd)/ > " --bind="change:top" --bind="ctrl-h:backward-kill-word" | sed "s:$:\':g" | sed "s:^:\':g" | tr '\n' ' '
}
FZF-DIR-SEARCH() {
tree -dCifa --gitignore -I "*syncbackup*" $HOME | fzf --reverse -m --ansi --height=50% --border=bold --prompt 'ALL DIRS > ' --bind="change:top" --bind="ctrl-h:backward-kill-word" | sed "s:$:\':g" | sed "s:^:\':g" | tr '\n' ' '
}
