#!/bin/bash
# Copyright 2023 Adrian Robinson <adrian dot j dot robinson at gmail dot com>
# https://github.com/transilluminate/toggle-wifi-led

# Modified from: https://www.topbug.net/blog/2015/01/13/control-the-led-on-a-usb-wifi-adapter-on-linux/

# Automate flashing at certain times: /etc/crontab
# 0 22    * * *   root    /path/to/bin/toggle-wifi-led.sh off
# 0  8    * * *   root    /path/to/bin/toggle-wifi-led.sh on

off()
{
  if [ "$(id -u)" -ne 0 ]; then echo "Please run as root to change settings!" >&2; exit 1; fi
  for device in /sys/class/leds/ath9k_htc-phy*; do
    echo "Set $device trigger:none, brightness:0"
    echo none > $device/trigger
    echo 0 > $device/brightness
  done
}

on()
{
  if [ "$(id -u)" -ne 0 ]; then echo "Please run as root to change settings!" >&2; exit 1; fi
  # LED options: phy0rx, phy0tx, phy0assoc, phy0radio, phy0tpt
  option=rx
  for device in /sys/class/leds/ath9k_htc-phy*; do
    id=$(echo $device | sed -e 's/.*ath9k_htc-phy\([0-9]\).*/\1/g')
    echo "Set $device trigger:phy${id}${option}"
    echo "phy${id}${option}" > $device/trigger
  done
}

state()
{
  for device in /sys/class/leds/ath9k_htc-phy*; do
    state=$(cat $device/trigger | sed -e 's/.*\[\(.*\)\].*/\1/g')
    echo "$device => trigger:$state"
  done
}

case "${1}" in
  on)
    on
    ;;
  off)
    off
    ;;
  state)
    state
    ;;
  *)
    echo "Usage: $0 {on|off|state}" >&2
    exit 1
    ;;
esac
exit 0
