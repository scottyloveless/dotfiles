#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

SPACE_CLICK_SCRIPT="aerospace workspace $sid"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --animate sin 10 \
        --set $NAME \
        label.color="$RED" \
        background.drawing=on
else
    sketchybar --animate sin 10 \
        --set $NAME \
        label.color="$COMMENT" \
        background.drawing=off
fi

# if [ "$SELECTED" = "true" ]; then
#     sketchybar --animate tanh 5 --set "$NAME" \
#         icon.color="$RED" \
#         icon="${SPACE_ICONS[$SID - 1]}" \
#         click_script="$SPACE_CLICK_SCRIPT"
# else
#     sketchybar --animate tanh 5 --set "$NAME" \
#         icon.color="$COMMENT" \
#         icon="${SPACE_ICONS[$SID - 1]}" \
#         click_script="$SPACE_CLICK_SCRIPT"
# fi
