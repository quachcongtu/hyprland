# Đây là một số thứ tôi dùng trên hyprland của mình

- ddcutil
- neovim
- ghostty
- tmux
- zsh
- wofi
- waybar
- fcitx5

## Cài đặt `ddcutil` để tăng giảm độ sáng của mà rời nhé (lưu ý là màn rời) còn màn laptop sẽ dùng `brightnessctl`

1.Cài ddcutil

```
$ sudo pacman -S ddcutil

```

2.Thêm quyền user

```
$ sudo usermod -aG i2c $USER
$ sudo udevadm control --reload-rules && sudo udevadm trigger

```
> Thêm quyền user xong thì đăng xuất hoặc reboot lại máy nhé.

3.Tạo scripts và gán phím vào trong file `~/.config/hypr/hyprland.conf`

- Tạo scripts: `~/scripts/brightness-control.sh`

```
#!/usr/bin/env bash

BUS=2

command -v ddcutil >/dev/null 2>&1 || {
  notify-send "brightness-control" "ddcutil chưa được cài đặt!"
  exit 1
}

# Kiểm tra màn có phản hồi không
if ! ddcutil getvcp 10 --bus=$BUS >/dev/null 2>&1; then
  notify-send "brightness-control" "Không thể giao tiếp với màn hình (bus=$BUS)"
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

```

- Cấp quyền chạy: `chmod +x ~/scripts/brightness-control.sh`

- Thêm vào hypr:

```
$ bind = SUPER, up, exec, ~/scripts/brightness-control.sh up
$ bind = SUPER, down, exec, ~/scripts/brightness-control.sh down

```

- `hyprctl reload`

- Kiểm tra xem hiện tại độ sáng là bao nhiêu bằng lệnh: `ddcutil getvcp 10 --bus=2`



