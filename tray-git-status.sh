#!/bin/bash

#  Decription
#  ----------
#  
#  Update tray icon depending if there are changes in Git repository.
#
#  ⚠ Note that it does not show any icon if repository is in sync
#
#  Check for new changes every 10 minutes.
#
#  See also [git-sync](https://github.com/dmi3/bin#git-sync)
#  
#  See https://stackoverflow.com/a/3278427/18078777

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ----------
#  1. `sudo apt-get install yad git`
#
#  Usage
#  -----
#      tray-git.sh

# create a FIFO file, used to manage the I/O redirection from shell
PIPE=$(mktemp -u --tmpdir ${0##*/}.XXXXXXXX)
mkfifo $PIPE

# Settings

FOLDER="$HOME/git/stuff"
CHECKTIME="10m"
# Clear icon and run git-sync
ON_CLICK="term bash -c 'echo icon: > $PIPE && git-sync $FOLDER'"

# attach a file descriptor to the file
exec 3<> $PIPE

# add handler to manage process shutdown
 function on_exit() {
    echo "quit" >&3
    rm -f $PIPE
 }
trap on_exit EXIT

# Start tray monitoring the fifo
yad --notification --listen --command="$ON_CLICK" <&3 &

cd $FOLDER
while true
do
    git remote update

    UNCOMMITTED=$(git status --porcelain=v1 2>/dev/null | wc -l)
    UPSTREAM="@{u}"
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $? -ne 0 ]; then
        ICON="error"
        TOOLTIP="Error"
    elif [ $UNCOMMITTED -ne 0 ]; then
        ICON="go-top"    
        TOOLTIP="Uncommited: $UNCOMMITTED"
    elif [ $LOCAL = $REMOTE ]; then
        # no icon if in sync
        ICON=""
    elif [ $LOCAL = $BASE ]; then
        ICON="bottom"
        TOOLTIP="Pull"
    elif [ $REMOTE = $BASE ]; then
        ICON="up"
        TOOLTIP="Push"
    else
        ICON="dialog-question"
        TOOLTIP="Diverged"
    fi

    # Send commands to fifo to update tray
    echo "icon:$ICON" >&3
    echo "tooltip:$TOOLTIP" >&3
    
    sleep $CHECKTIME
done

