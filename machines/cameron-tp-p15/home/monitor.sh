#!/usr/bin/env bash

function set-for-desk() {
  xrandr \
    --output HDMI-1-3 --auto --pos 0x0 \
    --output eDP-1 --auto --primary --pos 2560x360 \
  ;
}

set-for-desk

