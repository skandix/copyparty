#!/usr/bin/env bash
set -e

# take a screenshot with flameshot and send it to copyparty;
# the image url will be placed on your clipboard

# Store password in a file in your home directory, or as a string in clear text if you love living on the edge
PASSWORD_FILE="$HOME/.copyparty-secret"
PASSWORD_STRING="wark"

COPYPARTY_URL="https://a.ocv.me/up/"
FILENAME=$(date +%Y-%m%d-%H:%M:%S).png

# if password file do not exists, use password string
if [[ -f $PASSWORD_FILE ]]; then
    PASSWORD=$(<"$PASSWORD_FILE")
else
    PASSWORD="$PASSWORD_STRING"
fi

# if the user is using wayland or not
if [[ -n "$WAYLAND_DISPLAY" ]]; then
    flameshot gui -s -r | curl -sS -T- "$COPYPARTY_URL$FILENAME?pw=$PASSWORD" | tail -n 1 | wl-copy
else
    flameshot gui -s -r | curl -sS -T- "$COPYPARTY_URL$FILENAME?pw=$PASSWORD" | tail -n 1 | xsel -ib
fi
