# ~/.local/bin/toggle-waybar.sh
#!/bin/bash
if pgrep -x waybar > /dev/null; then
    pkill waybar
else
    waybar &
fi

