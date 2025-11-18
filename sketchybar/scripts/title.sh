#!/bin/bash

# 1. Get focused window info from Aerospace as a JSON array
TITLE_JSON=$(aerospace list-windows --focused --json)

# 2. Check if the result is an empty array '[]' (no window focused)
if [ "$TITLE_JSON" = "[]" ]; then
    sketchybar --set title_proxy label=""
    sketchybar --animate circ 15 --set title y_offset=70
    sketchybar --set title label=""
else
    # 3. Extract title and app name from the *first array element* '.[0]'
    LABEL="$(echo $TITLE_JSON | jq -r '.[0].title')"
    
    # 4. Fallback to 'app-name' if title is empty or null
    if [ "$LABEL" = "" ] || [ "$LABEL" = "null" ]; then
        LABEL="$(echo $TITLE_JSON | jq -r '.[0]."app-name"')"
    fi
    
    # 5. The rest of your script logic is unchanged
    if [ "$(sketchybar --query title_proxy | jq -r '.label.value')" != "$LABEL" ]; then
        sketchybar --set title_proxy label="$LABEL"
        sketchybar --animate circ 15 --set title y_offset=70 --set title padding_right=400 \
                   --animate circ 10  --set title y_offset=7 --set title padding_right=400 \
                   --animate circ 15 --set title y_offset=0  --set title padding_right=400

        
        sketchybar --set title label="$LABEL"
    fi
fi
