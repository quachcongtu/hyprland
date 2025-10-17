#!/bin/bash
# Toggle laptop screen (eDP-1) on/off for Hyprland

LAPTOP="eDP-1"

# Lấy danh sách monitor đang bật
ENABLED=$(hyprctl monitors | grep "$LAPTOP")

if [ -n "$ENABLED" ]; then
    # Nếu đang bật thì tắt
    notify-send "🔌 Tắt màn hình laptop ($LAPTOP)"
    hyprctl keyword monitor "$LAPTOP,disable"
else
    # Nếu đang tắt thì bật lại (đặt độ phân giải và vị trí tùy bạn)
    notify-send "💡 Bật lại màn hình laptop ($LAPTOP)"
    hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
fi

