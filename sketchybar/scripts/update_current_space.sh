#!/bin/zsh

# Add a tiny delay to wait for Aerospace to finish
# This prevents the race condition.
sleep 0.1

# Query aerospace manually for the current focused workspace
CURRENT_WS=$(aerospace list-workspaces --focused)

# Set the icon
if [ -n "$CURRENT_WS" ]; then
  # $NAME is automatically set by sketchybar to the item's name ("current_space")
  sketchybar --set $NAME icon="$CURRENT_WS"
fi
