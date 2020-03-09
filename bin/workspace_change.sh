#!/bin/bash

i3-msg "workspace $1"
notify-send -t 1000 -u normal "Workspace: $(i3-msg -t get_workspaces | jq '.[] | select(.focused == true).name')"
