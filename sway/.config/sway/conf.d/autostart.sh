exec gentoo-pipewire-launcher restart
exec dinit
exec Xwayland enable -rootless
exec {
    '[ -x "$(command -v wl-paste)" ] && [ -x "$(command -v cliphist)" ] && wl-paste --watch cliphist store'
    '[ -x "$(command -v wl-paste)" ] && [ -x "$(command -v cliphist)" ] && wl-paste --watch pkill -RTMIN+9 cliphist'
}

exec_always import-gsettings
