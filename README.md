# Useful scripts for Linux users

# [aliases.bash](https://github.com/dmi3/bin/blob/master/aliases.bash)

Decription
-----------

Some handy bash aliases

Requirements
------------

sudo apt-get install twistd pm-utils

Usage
-----

wget https://raw.githubusercontent.com/dmi3/bin/aliases.bash --no-check-certificate -O ~/bin/aliases.bash

echo "source ~/bin/aliases.bash" >> ~/.bashrc

To make bash more usable you probably want to install https://github.com/mrzool/bash-sensible

To make this work across remote machines, you also may want to install https://github.com/Russell91/sshrc 

<hr/>

# [backup_protectedtext.py](https://github.com/dmi3/bin/blob/master/backup_protectedtext.py)

Decription
-----------

Backup secrets from www.protectedtext.com to local storage

If file is changed, keep previous version with date postfix

Only backups once per day

Can be decrypted using `base64 -d BACKUP_FILE | openssl aes-256-cbc -d -k PASSWORD`

More info <http://developer.run/13>

Usage
-----

Run from commandline or add to cron

<hr/>

# [config.fish](https://github.com/dmi3/bin/blob/master/config.fish)

Decription
----------

Fish config with awesome prompt, unicode symbols, better fzf integration and lot of handy functions.

Instalation
----------

[Install fish](http://fishshell.com/#platform_tabs)

curl https://raw.githubusercontent.com/dmi3/bin/master/config.fish --create-dirs -o ~/.config/fish/config.fish

fish -c update-fzf

<hr/>

# [config/fish/completions/todo.fish](https://github.com/dmi3/bin/blob/master/config/fish/completions/todo.fish)

<hr/>

# [generate-readme.fish](https://github.com/dmi3/bin/blob/master/generate-readme.fish)

<hr/>

# [git-sync](https://github.com/dmi3/bin/blob/master/git-sync)

Decription
----------

Script to simply sync all changes into git repository with one line command. For example publish local changes to Github.

Requirements
----------

sudo apt-get install git

[Setup mergetool](https://developer.atlassian.com/blog/2015/12/tips-tools-to-solve-git-conflicts/)

Usage
-----

    git-sync /path/to/repo

    git-sync # current dir

    git-sync # if you want sync all files

    git-sync -u # if you want only sync files explicitly added via `git add filename`

<hr/>

# [itunec](https://github.com/dmi3/bin/blob/master/itunec)

Decription
-----------

Mounts USB device, syncs new podcast in gpodder then umounts device

Requirements
------------

sudo apt-get install python3 id3v2

wget https://raw.github.com/dmi3/bin/master/notify-append -P ~/bin && chmod +x ~/bin/notify-append

Usage
-----

set LABEL to label of your player filesystem (for example `SANSA CLIP` to find label type `ls -l /dev/disk/by-label/`)

set GPODDER_DIR to directory where gpodder download podcasts

run `itunec` when you want to sync

or

gpodder -> Podcasts -> Prefences -> Devices; set  Device type to `Filesystem-based` and `Mountpoint` path where device is mounted by default

gpodder -> Podcasts -> Prefences -> Edit config -> cmd_all_download_complete -> itunec

<hr/>

# [knok](https://github.com/dmi3/bin/blob/master/knok)

Decription
-----------

Knocks to given ports with 0.5 second delay. Useful when default knockd delay

is to short for server to react. Additionally displays Gun's N' Roses lyrics :)

Requirements
------------

sudo apt-get install knockd python3 python3-setuptools

sudo easy_install3 sh

Usage
-----

knock ip [port,port...]

<hr/>

# [layoutset](https://github.com/dmi3/bin/blob/master/layoutset)

Decription
-----------

Script to set keyboard layout depending if its Apple or regular keyboard + some settings

Usage
-----

layoutset

<hr/>

# [skypenotify](https://github.com/dmi3/bin/blob/master/skypenotify)

Decription
-----------

Script to run append Skype messages in Notify OSD as shown on http://thexnews.com/uploads/notify.gif

Since x-canonical-append is broken in notify-send for example in Skype you will wait forever untill all messages are shown

This script makes new messages readable in same notification window

Readme in russian: http://thexnews.com/p/554

Requirements
------------

wget https://raw.github.com/dmi3/bin/master/notify-append -P ~/bin && chmod +x ~/bin/notify-append

Usage: 

------

skypenotify "%sname" "%smessage"

<hr/>

# [sssh](https://github.com/dmi3/bin/blob/master/sssh)

Decription
-----------

Script to change your terminal title to user@host when connecting to ssh and changing 

it back after exiting. Additionally sets green prompt on remote host.

Useful for Keepassx and visual distinction to avoid notorious "wrong window" problem.

Also works when connecting Fish → Bash

Requirements
------------

sudo apt-get install xdotool

Usage
-----

sssh user@hostname

<hr/>

# [timer](https://github.com/dmi3/bin/blob/master/timer)

Decription
-----------

Simple timer with sound and dialog window notification. To remind you to turn stove off :). 

Replace pc_up.wav to any available audiofile. 

Requirements
------------

sudo apt-get install zenity vlc

Usage
-----

timer 6 # i.e. notify after 6 minutes

<hr/>

# [todo](https://github.com/dmi3/bin/blob/master/todo)

Wunderlist CLI client

---------------------

Decription
----------

Wrapper for [wl](https://github.com/robdimsdale/wl/releases) for adding todos with more convenient syntax

[Read More](http://developer.run/15)

Instalation
-----------

1. ⚠ Make sure [Fish shell](http://fishshell.com/#platform_tabs) > 2.3.0

2. `curl https://raw.githubusercontent.com/dmi3/bin/master/todo --create-dirs -o ~/bin/todo`

3. `curl https://raw.githubusercontent.com/dmi3/bin/master/config/fish/completions/todo.fish --create-dirs -o ~/.config/fish/completions/todo.fish`

4. <https://developer.wunderlist.com/apps>

5. [CREATE APP] (Put https://wunderlist.com to both `APP URL` and `AUTH CALLBACK URL`)

6. Set enviroment variables in this file (line 30)

7. Add more list shortcuts (line 38)

Usage
-----

     todo buy stuff --life --on next monday

     todo resolve issue --work --star

     todo --work meet customer --on jan 7

<hr/>

# [volume](https://github.com/dmi3/bin/blob/master/volume)

Decription
-----------

Script to control audio volume from console, hotkeys, e.t.c. Also shows nice Notify OSD buble with current volume value

Requirements
------------

sudo apt-get install pulseaudio notify-osd

Usage
-----

volume (up|down|mute)

<hr/>
