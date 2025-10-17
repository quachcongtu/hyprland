#!/usr/bin/env bash
set -euo pipefail

save_dir=~/screenshot
mkdir -p "$save_dir"

filename="Screenshot $(date +%Y-%m-%d) $(date +%H%M%S).png"
save_path="$save_dir/$filename"

case "${1:-}" in
  --full)
    grim "$save_path"
    ;;
  --select)
    if ! grim -g "$(slurp)" "$save_path"; then
      notify-send "Screenshot cancelled"
      exit 1
    fi
    ;;
  *)
    notify-send "❌ Invalid argument" "Use --full or --select"
    exit 1
    ;;
esac

wl-copy < "$save_path"
notify-send "📸 Screenshot saved" "$save_path"

