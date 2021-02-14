#!/bin/sh
# Script that will detect whether an external HDMI monitor is available and if
# so, send output to it; if not, shut it off.
# Should be idempotent: running this multiple times without changing connected
# displays won't do anything.

# Set X DISPLAY variable
DISPLAY=":0"

# Default names for outputs. May vary from system to system.
monitor="HDMI1"
default="eDP1"

if [ ! -n "$(xrandr | grep "$monitor")" ]; then
  echo No HDMI display named $monitor found via xrandr.
  exit 1
elif [ ! -n "$(xrandr | grep "$default")" ]; then
  echo No default display named $default found via xrandr.
  exit 1
fi

if [ -n "$(xrandr | grep "$monitor connected")" ]; then
  xrandr --output $monitor --auto --primary --pos 0x0 --output $default --auto --pos 320x1440
else
  xrandr --output $monitor --off
fi
