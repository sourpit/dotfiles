# Logo key. Use Mod1 for Alt.
set $mod Mod4
set $meta Mod1

# Home row direction keys, like vim
set $left h
set $down j
set $up k
set $right l

# Your preferred terminal emulator
set $term foot

# Your preferred application launcher
# Note: pass the final command to swaymsg so that the resulting window can be opened
# on the original workspace that the command was run on.
#set $menu dmenu_path | wmenu | xargs swaymsg exec --
set $menu tofi-drun | xargs swaymsg exec --

#
# Keybinds
#
    # Start a terminal
    bindsym $mod+t exec $term

    # Kill focused window
    bindsym $mod+q kill

    # Start your launcher
    bindsym $meta+space exec $menu

    # Editor
    bindsym $meta+n exec $term nvim

    # wallpaper
    bindsym shift+w+t exec pape.sh

    # powermenu
    bindsym $mod+p exec ~/.config/tofi/scripts/powermenu.sh

    # Volume control
    # ---
    # Sink volume raise optionally with --device
    bindsym XF86AudioRaiseVolume exec swayosd-client --output-volume raise --max-volume 120
    # Sink volume lower optionally with --device
    bindsym XF86AudioLowerVolume exec  swayosd-client --output-volume lower --max-volume 120
    # Sink volume toggle mute
    bindsym XF86AudioMute exec swayosd-client --output-volume mute-toggle
    # Source volume toggle mute
    bindsym XF86AudioMicMute exec swayosd-client --input-volume mute-toggle

    # Capslock (If you don't want to use the backend)
    bindsym --release Caps_Lock exec swayosd-client --caps-lock

    # Brightness control
    bindsym XF86MonBrightnessDown exec light -U 5
    bindsym XF86MonBrightnessUp exec light -A 5

    # Screenshot
    bindsym Print exec grim -g "$(slurp -d)" -t png - | wl-copy -t image/png
    bindsym $meta+p exec grim -g "$(slurp -d)" -t png -o "~/Pictures/$(date +'%s_grim.png')"
    bindsym CTRL+i exec sh -c 'f=$(mktemp /tmp/screenshot.XXXXXX.png); \
      trap "rm -f $f" EXIT; \
      grim -g "$(slurp -d)" "$f" && \
      imv "$f"'
    bindsym $mod+SHIFT+t exec grim -g "$(slurp)" -t png - | tesseract stdin stdout -l jpn | wl-copy

    # Open File Manager
    bindsym $meta+e exec $term yazi

    # Magnifier
    bindsym $mod+z exec hyprmag

    # Toggle touchpad
    bindsym $mod+u+d exec swaymsg input type:touchpad events disabled
    bindsym $mod+u+e exec swaymsg input type:touchpad events enabled

    # Music
    bindsym $mod+m exec $term -a "mpc" ncmpcpp

    # wf-recorder for streaming
    bindsym CTRL+t+w exec wf-recorder --audio -f "rtmp://live.twitch.tv/app/live_1150648356_KNeYUwhdH7C8i01I3i50XqnusVLraA" -c h264_vaapi -d /dev/dri/renderD128
    bindsym CTRL+Print exec wf-recorder -f ~/Videos/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") -c h264_vaapi -d /dev/dri/renderD128
    bindsym CTRL+Shift+BackSpace exec killall -s SIGINT wf-recorder

    # Drag floating windows by holding down $mod and left mouse button.
    # Resize them with right mouse button + $mod.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier $mod normal

    # Reload the configuration file
    bindsym $mod+Shift+r reload

    # Exit sway (logs you out of your Wayland session)
    bindsym $mod+Shift+q exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

#
# Moving around:
#
    # Move your focus around
    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right
    # Or use $mod+[up|down|left|right]
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # Move the focused window with the same, but add Shift
    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right
    # Ditto, with arrow keys
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

#
# Workspaces:
#

# Switch to workspace
    bindsym --no-repeat $mod+1 workspace number 1
    bindsym --no-repeat $mod+2 workspace number 2
    bindsym --no-repeat $mod+3 workspace number 3
    bindsym --no-repeat $mod+4 workspace number 4
    bindsym --no-repeat $mod+5 workspace number 5
    bindsym --no-repeat $mod+6 workspace number 6
    bindsym --no-repeat $mod+7 workspace number 7
    bindsym --no-repeat $mod+8 workspace number 8
    bindsym --no-repeat $mod+9 workspace number 9
    bindsym --no-repeat $mod+0 workspace number 10
    bindsym --no-repeat $mod+CTRL+1 workspace number 11
    bindsym --no-repeat $mod+CTRL+2 workspace number 12
    bindsym --no-repeat $mod+CTRL+3 workspace number 13
    bindsym --no-repeat $mod+CTRL+4 workspace number 14
    bindsym --no-repeat $mod+CTRL+5 workspace number 15
    bindsym --no-repeat $mod+CTRL+6 workspace number 16
    bindsym --no-repeat $mod+CTRL+7 workspace number 17
    bindsym --no-repeat $mod+CTRL+8 workspace number 18

    # Move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5
    bindsym $mod+Shift+6 move container to workspace number 6
    bindsym $mod+Shift+7 move container to workspace number 7
    bindsym $mod+Shift+8 move container to workspace number 8
    bindsym $mod+Shift+9 move container to workspace number 9
    bindsym $mod+Shift+0 move container to workspace number 10

    bindsym $mod+CTRL+Shift+1 move container to workspace number 11
    bindsym $mod+CTRL+Shift+2 move container to workspace number 12
    bindsym $mod+CTRL+Shift+3 move container to workspace number 13
    bindsym $mod+CTRL+Shift+4 move container to workspace number 14
    bindsym $mod+CTRL+Shift+5 move container to workspace number 15
    bindsym $mod+CTRL+Shift+6 move container to workspace number 16
    bindsym $mod+CTRL+Shift+7 move container to workspace number 17
    bindsym $mod+CTRL+Shift+8 move container to workspace number 18

    # Note: workspaces can have any name you want, not just numbers.
    # We just use 1-10 as the default.

    # Moving left and right with non-existing workspaces
    set $num_of_workspaces 20
    bindsym $mod+$meta+$left          exec swaymsg -pt get_workspaces | gawk -f ~/.config/sway/workspace.gawk -v move_type="left"  -v num_of_workspaces=$num_of_workspaces
    bindsym $mod+$meta+$right         exec swaymsg -pt get_workspaces | gawk -f ~/.config/sway/workspace.gawk -v move_type="right" -v num_of_workspaces=$num_of_workspaces
    bindsym $mod+control+$left  exec swaymsg -pt get_workspaces | gawk -f ~/.config/sway/workspace.gawk -v move_type="container_left"  -v num_of_workspaces=$num_of_workspaces
    bindsym $mod+control+$right exec swaymsg -pt get_workspaces | gawk -f ~/.config/sway/workspace.gawk -v move_type="container_right" -v num_of_workspaces=$num_of_workspaces
#
# Layout stuff:
#
    # You can "split" the current object of your focus with
    # $mod+b or $mod+v, for horizontal and vertical splits
    # respectively.
    bindsym $mod+b splith
    bindsym $mod+v splitv

    # Switch the current container between different layout styles
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Make the current focus fullscreen
    bindsym $mod+f fullscreen

    # Toggle the current focus between tiling and floating mode
    bindsym $mod+Shift+space floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym $mod+space focus mode_toggle

    # Move focus to the parent container
    bindsym $mod+a focus parent

#
# Scratchpad:
#
# Sway has a "scratchpad", which is a bag of holding for windows.
    # You can send windows there and get them back later.

    # Move the currently focused window to the scratchpad
    bindsym $mod+minus move scratchpad

    # Show the next scratchpad window or hide the focused scratchpad window.
    # If there are multiple scratchpad windows, this command cycles through them.
    bindsym alt+minus scratchpad show

#
# Resizing containers:
#
mode "resize" {
    # left will shrink the containers width
    # right will grow the containers width
    # up will shrink the containers height
    # down will grow the containers height
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px

    # Ditto, with arrow keys
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
