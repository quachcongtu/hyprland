#!/usr/bin/env bash
# Script điều chỉnh độ sáng màn rời (với log & kiểm tra lỗi)

BUS=2

# Kiểm tra lệnh ddcutil tồn tại
command -v ddcutil >/dev/null 2>&1 || {
  notify-send "❌ brightness-control" "ddcutil chưa được cài đặt!"
  exit 1
}

# Kiểm tra màn có phản hồi không
if ! ddcutil getvcp 10 --bus=$BUS >/dev/null 2>&1; then
  notify-send "❌ brightness-control" "Không thể giao tiếp với màn hình (bus=$BUS)"
  exit 1
fi

case "$1" in
  up)
    ddcutil setvcp 10 + 10 --bus=$BUS && notify-send "🌞 Tăng sáng màn rời" "↑ +10%"
    ;;
  down)
    ddcutil setvcp 10 - 10 --bus=$BUS && notify-send "🌚 Giảm sáng màn rời" "↓ -10%"
    ;;
  *)
    notify-send "⚙️ brightness-control" "Dùng: up / down"
    ;;
esac

