#!/usr/bin/env bash

# Identify your battery path (usually BAT0 or BAT1)
BAT_PATH=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n 1)

[ -z "$BAT_PATH" ] && exit 1

LAST_NOTIFIED=-1

while true; do
    CAPACITY=$(cat "$BAT_PATH/capacity")
    STATUS=$(cat "$BAT_PATH/status")

    # Reset trigger history once plugged back in or charged above 10%
    if [ "$STATUS" = "Charging" ] || [ "$CAPACITY" -gt 10 ]; then
        LAST_NOTIFIED=-1
    elif [ "$STATUS" = "Discharging" ]; then
        # Condition: Trigger at exactly 10%, 5%, or every integer <= 4
        if { [ "$CAPACITY" -eq 10 ] || [ "$CAPACITY" -eq 5 ] || [ "$CAPACITY" -lt 5 ]; } && [ "$CAPACITY" -ne "$LAST_NOTIFIED" ]; then
            
            if [ "$CAPACITY" -eq 10 ]; then
                URGENCY="normal"
                TITLE="Battery Low (10%)"
                BODY="Plug in your charger soon."
            elif [ "$CAPACITY" -eq 5 ]; then
                URGENCY="critical"
                TITLE="Battery Critical (5%)"
                BODY="Connect AC power immediately."
            else
                URGENCY="critical"
                TITLE="Battery Depleted (${CAPACITY}%)"
                BODY="Imminent shutdown. Connect AC power NOW."
            fi

            dunstify -a "Power" \
                     -u "$URGENCY" \
                     -h string:x-dunst-stack-tag:battery_alert \
                     -i battery-caution \
                     "$TITLE" "$BODY"

            LAST_NOTIFIED="$CAPACITY"
        fi
    fi

    # Poll every 15 seconds
    sleep 15
done
