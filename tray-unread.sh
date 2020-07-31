#!/bin/bash

#  Decription
#  ----------
#  Update tray icon depending on script result. Current example shows unread mail count for Evolution mail (for those poor souls who need exchange but don't have web client), but actually in can check and notify about literally anything!
#  Read more:
#  * <https://sourceforge.net/p/yad-dialog/wiki/NotificationIcon/>
#  * <https://dset0x.github.io/mail-counting.html>

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Requirements
#  ----------
#  1. `sudo apt-get install yad`
#  2. For Evolution `sudo apt-get install sqlite3`

#  Usage
#  -----
#      tray-unread.sh

# create a FIFO file, used to manage the I/O redirection from shell
PIPE=$(mktemp -u --tmpdir ${0##*/}.XXXXXXXX)
mkfifo $PIPE

# attach a file descriptor to the file
exec 3<> $PIPE

# add handler to manage process shutdown
function on_exit() {
    echo "quit" >&3
    rm -f $PIPE
}
trap on_exit EXIT

# Start tray monitoring the fifo
yad --notification --listen --command="wmctrl -a evolution" <&3 &

while true
do
    # Replace next with script of your choice
    UNREAD=$(for i in ~/.cache/evolution/mail/*; do
        test $(basename $i) = "trash" && continue 
        sqlite3 "$i/folders.db" "select count(*) read from INBOX where read == 0"
    done | awk '{ SUM += $1} END { print SUM }')

    # Set icon depending $UNREAD = 0
    ICON=$(test $UNREAD = 0 && echo "internet-mail" || echo "info")
    # In case Evolution is not running - show error icon
    pgrep -x evolution > /dev/null || ICON="error"

    # Send commands to fifo to update tray
    echo "icon:$ICON" >&3
    echo "tooltip:Unread: $UNREAD" >&3
    
    sleep 10
done

