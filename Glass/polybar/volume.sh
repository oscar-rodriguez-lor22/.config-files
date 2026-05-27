#!/bin/bash
pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d{1,3}(?=%)' | head -1
