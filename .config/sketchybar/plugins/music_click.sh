#!/usr/bin/env bash

PLAYER_STATE=$(osascript -e "tell application \"Music\" to set playerState to (get player state) as text")
PLAYPAUSE=$(osascript -e "tell application \"Music\" to playpause")

if [[ $PLAYER_STATE == "playing" ]]; then
    $PLAYPAUSE
fi

if [[ $PLAYER_STATE == "paused" ]]; then
    $PLAYPAUSE
fi
