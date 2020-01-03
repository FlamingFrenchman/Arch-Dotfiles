#!/bin/bash

i3-msg "workspace $1"
notify-send -t 2000 -u normal "Workspace: $1"
