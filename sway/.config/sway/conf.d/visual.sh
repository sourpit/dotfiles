#--- Windows Decoration --------------------------------
# Gaps
# gaps inner 3
# gaps outer 3
smart_gaps on

# Frame thickness for regular and floating windows
default_border none
default_floating_border none

# Window frame size
for_window [tiling] border pixel 1
for_window [floating] border none

# fixing stacking splits
# hide_edge_borders --i3 none

# Disabling the frame if one window is open
smart_borders on

# Move minimized windows into Scratchpad (enable|disable)
scratchpad_minimize enable

#--- Appearance ----------------------------------------
# window corner radius in px
corner_radius 7
smart_corner_radius enable

# Window background blur
blur enable
blur_xray disable
blur_passes 3
blur_radius 3

shadows on
shadows_on_csd off
shadow_blur_radius 10
shadow_color #0D0D0D

client.focused          #453a3a #453a3a #ebdbb2 #fabd2fff #fabd2fff
client.unfocused        #1d2021 #282828 #ebdbb2 #453a3a #453a3a
client.focused_inactive #453a3a #453a3a #ebdbb2 #453a3a #453a3a
# client.urgent #900000 #2f343a #ffffff #900000 #900000

# inactive window fade amount. 0.0 = no dimming, 1.0 = fully dimmed
default_dim_inactive 0.0
dim_inactive_colors.unfocused #000000FF
dim_inactive_colors.urgent    #900000FF

# Cursor theme
seat seat0 xcursor_theme WhiteSur-cursors 40
