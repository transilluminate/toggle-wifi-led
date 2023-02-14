# toggle-wifi-led

- Bash script to toggle the WiFi LED (works on the [TL-WN722N](https://www.amazon.co.uk/TP-LINK-TL-WN722N-Mbps-Wireless-Adapter/dp/B002SZEOLG))
- [Modified from this blog post](https://www.topbug.net/blog/2015/01/13/control-the-led-on-a-usb-wifi-adapter-on-linux/)
- works on Raspberry Pi, and likely any similar Linux install

## Usage

```
$ toggle-wifi-led.sh [on|off|state]
```

## Automation in `/etc/crontab`

```
0 22    * * *   root    /path/to/bin/toggle-wifi-led.sh off
0  8    * * *   root    /path/to/bin/toggle-wifi-led.sh on
```
