#!/bin/bash

echo "Starting spacebar automation..."
echo "Press [CTRL+C] in this terminal to stop."
echo "----------------------------------------"

# Loop indefinitely until interrupted
while true
do
    # Simulate pressing the space bar
    xdotool key space
    
    # Wait for 2 seconds
    sleep 1.1
done
