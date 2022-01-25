#!/usr/bin/env bash

set -x

if [ "$__LOGGING__" != "yes" ]; then
    THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    OUT=$THIS_DIR/xstart.log
	__LOGGING__="yes" $0 > $OUT 2>&1
	exit 0
fi

pwd
echo $USER

xrdb -merge .Xresources

# TODO: move xmobar to home-manager systemd service
pkill xmobar
xmobar &

# TODO: move xscreensaver to home-manager systemd service
# also needs sudo
# pkill xscreensaver
# xscreensaver --no-splash &
