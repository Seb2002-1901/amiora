#!/bin/bash
# Prise propre : écran X neuf, une seule instance, enregistrement continu.
set -e
export DISPLAY=:99
pkill -9 -x amiora 2>/dev/null || true
pkill -9 -x Xvfb 2>/dev/null || true
pkill -9 -x ffmpeg 2>/dev/null || true
sleep 1
rm -f /tmp/.X99-lock /tmp/.X11-unix/X99
Xvfb :99 -screen 0 420x940x24 >/dev/null 2>&1 &
sleep 2
rm -f /root/.local/share/ch.amiora.amiora/amiora.sqlite
/home/user/amiora/app/build/linux/x64/release/bundle/amiora >/tmp/amiora-app.log 2>&1 &
sleep 5
[ "$(pgrep -c -x amiora)" = "1" ] || { echo "instances: $(pgrep -c -x amiora)"; exit 9; }
ffmpeg -y -loglevel error -f x11grab -framerate 15 -video_size 420x940 -i :99 "$1" &
FF=$!
sleep 1
source /home/user/amiora/captures/actions.sh
sleep 1.5
kill $FF; wait $FF 2>/dev/null || true
pkill -9 -x amiora 2>/dev/null || true
echo "prise OK: $1"
