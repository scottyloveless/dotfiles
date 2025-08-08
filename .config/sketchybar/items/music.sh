#!/bin/bash

COLOR="$RED"

sketchybar -m --add event song_update com.apple.iTunes.playerInfo

sketchybar --add item music q \
    --set music \
    --animate sin 10 \
    scroll_texts=on \
    icon=󰎆 \
    icon.color="$COLOR" \
    icon.padding_left=10 \
    background.color="$BAR_COLOR" \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$COLOR" \
    background.padding_right=-5 \
    background.drawing=on \
    label.padding_right=10 \
    label.max_chars=23 \
    associated_display=active \
    updates=on \
    script="$PLUGIN_DIR/music.sh" \
    click_script="~/.config/sketchybar/scripts/music_click" \
    --subscribe music song_update
