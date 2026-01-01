#!/bin/sh
# shellcheck disable=SC2155

# Make runtime dir if not found
if test -z "${XDG_RUNTIME_DIR}"; then
  export XDG_RUNTIME_DIR=$(mktemp -d "${UID}-runtime-dir.XXX")
fi

# xdg dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Add all directories in `~/.local/bin` to $PATH
export PATH="$PATH:$(find ~/.local/bin -type d | paste -sd ':' -)"
export PATH="$PATH:$(find ~/.local/share/cargo/bin -type d | paste -sd ':' -)"

unsetopt PROMPT_SP 2>/dev/null

# Default programs:
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="foot"
export TERMINAL_PROG="foot"

# Fractional Scaling
export QT_SCREEN_SCALE_FACTOR="2;2"
export QT_AUTO_SCREEN_SCALE_FACTOR=2
export QT_ENABLE_HIGHDPI_SCALING=2
export GDK_DPI_SCALE=1
export QT_FONT_DPI=128

# Window Protocol
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export WLR_RENDERER=vulkan

# ~/ Clean-up:
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GRADLE_USER_HOME="$XDG_CONFIG_HOME/gradle"
export HISTFILE="$XDG_DATA_HOME/history/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export ZK_NOTEBOOK_DIR="$HOME/repo/notes"
export _ZL_DATA="$XDG_DATA_HOME/autojump/zlua"
export W3M_DIR="$XDG_CONFIG_HOME/w3m"

# Other program settings:
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS="R"
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"
export _JAVA_AWT_WM_NONREPARENTING=1
export MPD_PORT=6699
export MOZ_USE_XINPUT2=1
export MYVIMRC="$XDG_CONFIG_HOME/nvim/init.lua"
export USE_SYS_UTILS=1

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Wayland >/dev/null 2>&1 && exec dbus-launch --exit-with-session sway
