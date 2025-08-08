#!/usr/bin/env bash

VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

audio_device="$(SwitchAudioSource -c)"

if [[ "$audio_device" == *"AirPods Max"* ]]; then
    ICON=""
elif [[ "$audio_device" == *"AirPods Pro"* ]]; then
    ICON="󱡏"
elif [[ "$audio_device" == *"Speakers"* ]]; then
    ICON="󰓃"
else
    ICON=""
    color="$RED"
fi

sketchybar -m \
    --set "$NAME" icon=$ICON \
    --set "$NAME" label="$VOLUME%"
