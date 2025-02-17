# Useful scripts for Linux users
See my [Fish config](https://github.com/dmi3/fish) for more CLI awesomness

# [wa](https://github.com/dmi3/bin/blob/master/wa)


Description
-----------
<img src="https://developer.run/pic/wa_full.png"/> 
<img src="https://developer.run/pic/wa.png"/> 
<img src="https://developer.run/pic/wa2.png"/> 

Using Wolfram Alpha in command line. See [blog post](http://developer.run/37) for description and more ideas.

Requirements
------------
* Make sure to configure variables in script
* Put [api key](https://products.wolframalpha.com/api/) in `APPID`
* For `VIEWER`, you can use text only api and **optionaly** use [terminal that supports images](https://developer.run/40)
**or** `sudo apt-get install imagemagick` to view images.
* Configure `BG` and `FG` variables depending on color scheme

Usage
------------
    ➤ wa helsinki to dublin plane
    2 hours 20 minutes                                                                                           
    ➤ wa time in dublin
    5:37:57 pm GMT; Friday, January 27, 2017
    ➤ wa 15.36 english money to eur
    14.35 euros                                                                                                          
    ➤ wa days till nov 16
    293 days
    ➤ wa 154Mbit/s to MB/s
    19.2 megabytes per second
    ➤ wa brick red hex
    #AB0303 
    ➤ wa weather in moscow
    9 degrees Celsius and cloudy, with light winds✖
    ➤ wa plot x=y^2
    [...draws plot if supported]
    ➤ # many many more usages... https://www.wolframalpha.com/examples/
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

# [vlc-now.sh](https://github.com/dmi3/bin/blob/master/vlc-now.sh)


Description
-----------
Show file or stream currently playing in VLC. Works well with (with xfce4-genmon-plugin). See `playerctl -h` for another players.

Requirements
------------
* `sudo apt-get install vlc playerctl`

Usage
------------
* `vlc-now`
**Includes useful functions**
* `cutExt() {
* `wrapInBrackets() {
* `basename() {
* `urlDecode() {
<hr/>

# [url-preview-md.py](https://github.com/dmi3/bin/blob/master/url-preview-md.py)


Decription
-----------
Wrapper around [webpreview](https://pypi.org/project/webpreview/). Takes url, downloads a preview image
(or image iself, if url points to image) and returns formatted markdown with page title and description.
Useful with clipboard manager. [Read more](https://developer.run/70)

Requirements
------------
    pip install webpreview

Usage
-----
    $ url-preview-md.py img_directory url
    $ url-preview-md.py ~/img http://developer.run/70
    [Markdown Url Preview](http://developer.run/70) Markdown Url Preview in text editor.
    ![](/home/dmi3/img/2023_09_01_developer.run_url-preview-md.png)
    If you have OpenGraph.io api key, add it as last argument to try it if webpreview finds nothing useful
    $ url-preview-md.py ~/img http://developer.run/70 e2b0e47c-8a03-11ef-b1b2-13950b80fc62
<hr/>

# [tray-unread.sh](https://github.com/dmi3/bin/blob/master/tray-unread.sh)

<img src="https://developer.run/pic/tray-unread.gif"/>

Decription
----------

Update tray icon depending on script result. Current example shows unread mail count for Evolution mail (for those poor souls who need exchange but don't have web client), but actually it can check and notify about literally anything!
Another example [shows Git repository status](https://github.com/dmi3/bin#tray-git-statussh).

On click simulates some keypresses to mark all mail as read.

Read more:
* <https://sourceforge.net/p/yad-dialog/wiki/NotificationIcon/>
* <https://dset0x.github.io/mail-counting.html>

Requirements
----------
1. `sudo apt-get install yad`
2. For Evolution `sudo apt-get install sqlite3 wmctrl xdotool`

Usage
-----
    tray-unread.sh
<hr/>

# [tray-git-status.sh](https://github.com/dmi3/bin/blob/master/tray-git-status.sh)


Decription
----------

Update tray icon depending if there are changes in Git repository.
⚠ Note that it does not show any icon if repository is in sync
Check for new changes every 10 minutes.
See also [git-sync](https://github.com/dmi3/bin#git-sync)

See https://stackoverflow.com/a/3278427/18078777

Requirements
----------
1. `sudo apt-get install yad git`

Usage
-----
    tray-git.sh
<hr/>

# [translation-insert.sh](https://github.com/dmi3/bin/blob/master/translation-insert.sh)


Decription
----------
Prompts for text. Then inputs translation. Works in any application.

Requirements
----------
1. Setup https://github.com/dmi3/bin/blob/master/yandex-translate.sh
2. `sudo apt-get install zenity xsel`

Usage
-----
* Bind script to hotkey in your DE. After input wait couple of seconds for translation to appear.
<hr/>

# [translate-yandex.sh](https://github.com/dmi3/bin/blob/master/translate-yandex.sh)


Decription
----------
CLI Yandex Translate API ru↔en. Automatically detects language. Translates any language to Russian, and Russian to English.

Usage
-----
    yandex-translate.sh cat is a small, typically furry, carnivorous mammal # en → ru
    yandex-translate.sh die Hauskatze ist eine Unterart der Wildkatze # de → ru
    yandex-translate.sh кот это маленькое, пушистое и очень хитрое млекопитающее # ru → en
<hr/>

# [translate-selection.sh](https://github.com/dmi3/bin/blob/master/translate-selection.sh)


Decription
----------
Show popup with translation of selected text. Works in any application.

Requirements
----------
1. Setup https://github.com/dmi3/bin/blob/master/yandex-translate.sh
2. `sudo apt-get install zenity xsel`

Usage
-----
* Bind script to hotkey in your DE.
* Select any text. Press hotkey.
<hr/>

# [tomatych.py](https://github.com/dmi3/bin/blob/master/tomatych.py)

<img src="http://developer.run/pic/tomatych.png"/>

Description
-----------
* Simple Hackable Pomodoro Timer with optional Slack and Habitica integrations.
* Intended to be hacked and modified to fit your specific vision of how Pomodoro timers should work.
* Moved to [separate repo](https://github.com/dmi3/tomatych)
<hr/>

# [todo](https://github.com/dmi3/bin/blob/master/todo)

Wunderlist CLI for adding todos
===============================

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
5. `[CREATE APP]` (Put https://wunderlist.com to both `APP URL` and `AUTH CALLBACK URL`)
6. Set enviroment variables in this script ↓ (line 31)
7. Add more list shortcuts ↓ (line 39)

Usage
-----
     todo buy stuff --life --on next monday
     todo resolve issue --work --star
     todo --work meet customer --on jan 7
<hr/>

# [timer](https://github.com/dmi3/bin/blob/master/timer)


Decription
-----------
Simple timer with sound and dialog window notification. To remind you to turn stove off :). 
Replace pc_up.wav to any available audiofile. 

Requirements
------------
    sudo apt-get install dunst aplay

Usage
-----
    timer 6 # i.e. notify after 6 minutes
<hr/>

# [temp.sh](https://github.com/dmi3/bin/blob/master/temp.sh)


Decription
----------
Shows CPU, System and GPU temperature

Requirements
------------
    sudo apt-get install jq lm-sensors nvidia-smi

Usage
-----
  temp
<hr/>

# [status.sh](https://github.com/dmi3/bin/blob/master/status.sh)


Description
-----------
![Status](https://developer.run/pic/status.png)

CLI web stats dashboard. Visualizes GitHub followers, top GitHub repos and last 500 blog hits
with top pages and refferers. Works well in addition to [headlines.sh](https://github.com/dmi3/bin/blob/master/headlines.sh) and `newsbeuter -x reload -x print-unread 2> /dev/null` [Read more](https://developer.run/51)

Requirements
------------
* [spark](https://github.com/holman/spark) (the other spark, not the behemoth one)
* `sudo apt-get install jq`

Usage
------------
* Set `URL`, `GITHUB_ID, `PARSE_APP_ID` and `PARSE_MASTER_KEY` variables
* `status.sh`
<hr/>

# [sssh2](https://github.com/dmi3/bin/blob/master/sssh2)


Decription
-----------
Like [sssh](https://github.com/dmi3/bin/blob/master/sssh), in addition:
* `hostname` parameter of [ssh command](https://manpage.me/?q=ssh) will appear in title.
  - Useful when calling by nickname from local `~/.ssh/config` i.e. `ssh server_nickname`, and change of server hostname is not an option.
* If command supports tunneling, display it in title
  - I.e. `ssh -L 80:localhost:80 server_nickname` will set title `user@[80]server_nickname`
  - Avoid accidental closing of such tabs
* Appends some useful [aliases](https://github.com/dmi3/fish/blob/master/aliases.fish) to existing `~/.bashrc`
* Preserves command history on multiple sessions

Usage
-----
See [sssh](https://github.com/dmi3/bin/blob/master/sssh)
<hr/>

# [sssh](https://github.com/dmi3/bin/blob/master/sssh)


Decription
-----------
Script to change your terminal title to user@host when connecting to ssh and changing 
it back after exiting. Additionally sets green prompt on remote host.
Useful for Keepassx and visual distinction to avoid notorious "wrong window" problem.
Also works when connecting Fish → Bash
If you want hostname from local `~/.ssh/config` file to appear in title use [sssh2](https://github.com/dmi3/bin/blob/master/sssh2).

Requirements
------------
`sudo apt-get install xdotool`

Usage
-----
`sssh user@hostname`
`alias ssh=sssh`
<hr/>

# [snippy.sh](https://github.com/dmi3/bin/blob/master/snippy.sh)


Decription
----------
System wide text snippet expander. Simulates cut→replace→paste so works in almost any application. Examples:
* Type `->`, press hotkey, get `→`. 
* Type `thx`, press hotkey, get `Thank you`.
Original idea by [sessy](https://bbs.archlinux.org/viewtopic.php?id=71938) and [Linux Magazine](http://www.linux-magazine.com/Issues/2014/162/Workspace-Text-Expander) with following improvements:
* Works as keybinding in Compiz/Unity/Openbox
* Does not go crazy if keybinding includes Ctrl, Alt, Shift...
* Works in Sublime Text/IntelliJ Idea/Chrome/Slack
* Expands snippets without preceding space i.e. `30eur` to `30€`
   - If snippet needs preceding space or start of line - use regexp `\b` i.e. `s/\bv$/✔/g;` converts `v` to `✔` only if its separate symbol
* Expands snippets with symbols i.e. `->` to `→`
* Expands commands i.e. `now` to formatted todays date, `mon` to to formatted next mondays date
* Stores all snippets in one file
* Works with Ubuntu 16.04

Requirements
----------
`sudo apt-get install xdotool xclip xsel`

Usage
-----
* Bind script to hotkey in your DE, for example Shift+Tab.
* Add new snippets after line 30, in format `s/SHORCUT$/REPLACEMENT/g;`
<hr/>

# [skypenotify](https://github.com/dmi3/bin/blob/master/skypenotify)


Decription
-----------
Script to run append Skype messages in Notify OSD as shown on http://thexnews.com/uploads/notify.gif
Since `x-canonical-append` is broken in notify-send for example in Skype you will wait forever untill all messages are shown
This script makes new messages readable in same notification window
[Readme in russian](http://thexnews.com/p/554)

Requirements
------------
`wget https://raw.github.com/dmi3/bin/master/notify-append -P ~/bin && chmod +x ~/bin/notify-append`

Usage 
-----
`skypenotify "%sname" "%smessage"`
<hr/>

# [rundesktop](https://github.com/dmi3/bin/blob/master/rundesktop)


Decription
-----------
Execute `.desktop` file from terminal

Usage
-----
rundesktop /usr/share/applications/firefox.desktop
<hr/>

# [reboot](https://github.com/dmi3/bin/blob/master/reboot)


Decription
----------
See <https://github.com/dmi3/bin/blob/master/poweroff>
<hr/>

# [random-wallpaper.sh](https://github.com/dmi3/bin/blob/master/random-wallpaper.sh)


Decription
----------
Sets the wallpaper, randomly selecting one from a folder. If the wallpaper is smaller than the screen, it also changes the surrounding area to a color that matches the wallpaper's palette.

Instalation
-----------
    sudo apt-get install nitrogen coreutils

Usage
-----
* Put some nice pictures in ~/wallpapers/
* Call this script by cron, on boot or login
* If you want fixed background color - put one in ~/wallpapers/bg_color
* You may want to change `--set-centered` to `--set-auto` depending on how picture should be scaled.
<hr/>

# [print-numbers.py](https://github.com/dmi3/bin/blob/master/print-numbers.py)


Decription
-----------
Font especially designed to fit 6 digits to 20x8 screens
For some reason [miniwi.flf](https://github.com/xero/figlet-fonts/blob/master/miniwi.flf) [figlet font](https://developer.run/26) is not working in tty
Useful for [Raspberry Pi 2fa](https://developer.run/45)
```
    ▐ ██ ██ ▌▐ ██ ██
    ▐  ▐  ▐ ▌▐ ▌  ▌
    ▐ ██ ██ ██ ██ ██
    ▐ ▌   ▐  ▐  ▐ ▌▐
    ▐ ██ ██  ▐ ██ ██
```

Usage
-----
    python3 numbers.py 123456
<hr/>

# [poweroff](https://github.com/dmi3/bin/blob/master/poweroff)


Decription
----------
Gracefully closes all running X applications, then powers off the computer.
Make sure to avoid conflicts with system `poweroff` is such exists.
Useful to avoid issues when calling `poweroff` from console:
* "The database you are trying to open is locked by another instance of KeePassXC.",
* "Well, this is embarrassing. Firefox is having trouble recovering your windows and tabs."
* Spotify forgetting current playlist
* etc

Requirements
----------
1. `sudo apt-get install wmctrl`
<hr/>

# [plug](https://github.com/dmi3/bin/blob/master/plug)


Description
----------
Interactive (un)mount of hotplug devices (USB drives) from console using FZF!
Outputs path to mounted device so could be used in alias to actomatically
`cd` to mounted directory.

Requirements
----------
1. `sudo apt-get install jq fzf udisks2`
2. `alias unplug='plug -u'`
3. `cd` to mounted directory:
  - Fish shell: `alias plug='cd (command plug)'`
  - Bash shell: `alias plug='cd $(command plug)'`

Usage
-----
    $ plug
    >         ACRONIS_MED     DataTraveler_2.0        sdb1     
              DATA            DataTraveler_3.0        sdc1
    Mounted /dev/sdb1 at /media/dmi3/ACRONIS_MED.
    $ plug -u
    > /media/dmi3/ACRONIS_MED ACRONIS_MED     DataTraveler_2.0                sdb1                                                                                                                          
      /                       workbuntu2020   Samsung_SSD_860_EVO_M.2_500GB   sda2                                                                                                                                  
      /media/dmi3/ElTorito    ElTorito        Samsung_SSD_860_EVO_M.2_500GB   sda1 
    Unmounted /dev/sdb1 
<hr/>

# [notify-append](https://github.com/dmi3/bin/blob/master/notify-append)


Decription
-----------
Script to run append Notify OSD messages as shown on http://thexnews.com/uploads/notify.gif
Since x-canonical-append is broken in notify-send for example in Skype you will wait forever untill all messages are shown
This script makes new messages shown in same notification window bellow the already shown
Created as addition to notify-send. Use notify-send when you want to send notification and notify-append when you want append or replace it.
[Readme in russian](http://thexnews.com/p/554)
<hr/>

# [mus.sh](https://github.com/dmi3/bin/blob/master/mus.sh)


Decription
----------
Setups MUS (Minimal Usable System). Targets very slow machines with very broken disks and very bad internet, so checks everything.

Usage
-----
    /usr/bin/GET https://raw.githubusercontent.com/dmi3/bin/master/mus.sh > ~/mus.sh && chmod +x ~/mus.sh && ~/mus.sh
<hr/>

# [memory-available.sh](https://github.com/dmi3/bin/blob/master/memory-available.sh)


Decription
----------
Prints free memory in gigabytes. Sends urgent notification if usage is less than defined value.
Cached memory is considered free.
Works best with [indicator-sysmonitor](https://github.com/fossfreedom/indicator-sysmonitor) and [dunst](http://developer.run/23)

Requirements
----------
1. `sudo apt-get install notify-send `
<hr/>

# [layoutset](https://github.com/dmi3/bin/blob/master/layoutset)


Decription
-----------
Script to set keyboard layout depending if its Apple or regular keyboard + some settings

Usage
-----
`layoutset`
<hr/>

# [knok](https://github.com/dmi3/bin/blob/master/knok)


Decription
-----------
Knocks to given ports with 0.5 second delay. Useful when default knockd delay
is to short for server to react. Additionally displays Bob Dylan's lyrics :)

Requirements
------------
1. `sudo apt-get install knockd python3 python3-setuptools`
2. `sudo easy_install3 sh`

Usage
-----
`knock ip [port,port...]`
<hr/>

# [itunec](https://github.com/dmi3/bin/blob/master/itunec)


Decription
-----------
Mounts USB device, syncs new podcast in gpodder then umounts device

Requirements
------------
1. `sudo apt-get install python3 id3v2`
2. `wget https://raw.github.com/dmi3/bin/master/notify-append -P ~/bin && chmod +x ~/bin/notify-append`

Usage
-----
1. set LABEL to label of your player filesystem (for example `SANSA CLIP` to find label type `ls -l /dev/disk/by-label/`)
2. set GPODDER_DIR to directory where gpodder download podcasts
3. run `itunec` when you want to sync
or
1. gpodder -> Podcasts -> Prefences -> Devices; set  Device type to `Filesystem-based` and `Mountpoint` path where device is mounted by default
2. gpodder -> Podcasts -> Prefences -> Edit config -> cmd_all_download_complete -> itunec
<hr/>

# [headlines.sh](https://github.com/dmi3/bin/blob/master/headlines.sh)

<img src="https://developer.run/pic/headlines.png"/>

Description
-----------
* Prints ground shaking headlines from Hacker News in shell greeting
* Don't miss next Meltdown, be notified right away!
* Doesn't distract you if nothing important happened
* Allows open all news in browser and mark it as read
* If you prefer simpler version without additional functionality refer [to initial version](https://github.com/dmi3/bin/blob/2fb9f8a894ea4eba5edb13c7135861740de83084/headlines.sh)
* See <http://developer.run/27> for description and more ideas

Requirements
------------
    sudo apt-get install jq

Usage
------------
* `headlines.sh` will print latest headlines
* `headlines.sh read` will open all news in browser and mark it as read (hide)
  - `~/.readnews` stores titles and urls of read news
  - `~/.readnews` might be useful if you want to find article later
  - `~/.readnews` might be synced between computers
* `headlines.sh clear` will mark all news as read (hide)
* Add to shell greeting [see screenshot](https://developer.run/pic/headlines.png)
  - <https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/>
  - OR `chmod 777 /var/run/motd.dynamic` on boot and `headlines.sh > /var/run/motd.dynamic`
  - OR `chmod 777 /var/run/motd.dynamic` on boot and put `0 */2 * * * /path/to/headlines.sh > /var/run/motd.dynamic` to `crontab -e`
  - To read and update greeting use `headlines.sh read > /var/run/motd.dynamic && clear`    
<hr/>

# [git-sync](https://github.com/dmi3/bin/blob/master/git-sync)


Decription
----------
Script to simply sync all changes into git repository with one command. For example publish local changes to Github.

Requirements
----------
1. `sudo apt-get install git`
2. [Setup mergetool](https://developer.atlassian.com/blog/2015/12/tips-tools-to-solve-git-conflicts/#parade-of-merge-tools)

Usage
-----
    git-sync /path/to/repo
    git-sync # current dir
    git-sync # if you want sync all files
    git-sync -u # if you want only sync files explicitly added via `git add filename`
<hr/>

# [generate-readme.fish](https://github.com/dmi3/bin/blob/master/generate-readme.fish)


Decription
----------
Generates this readme

Usage
-----
     echo -e "#!/bin/sh\necho \# Useful scripts for Linux users > README.md\necho \"See my [Fish config](https://github.com/dmi3/fish) for more CLI awesomness\" >> README.md\ngenerate-readme.fish --reverse >> README.md\nshasum -a 256 * | grep -v 'SHASUMS\|config' > SHASUMS" > .git/hooks/pre-commit
     chmod +x .git/hooks/pre-commit    
<hr/>

# [game-screenshot.sh](https://github.com/dmi3/bin/blob/master/game-screenshot.sh)


Description
-----------
Saves full screen screenshot with current window name and date to predefined folder and plays sound if successful.

Requirements
------------
* `sudo apt-get install scrot xdotool`

Usage
------------
* Bind a hotkey to `game-screenshot.sh /path/to/folder`
<hr/>

# [ex-spotify-playlist.sh](https://github.com/dmi3/bin/blob/master/ex-spotify-playlist.sh)

Export playlists from Spotify without giving credentials to shady sites (to avoid your Spotify credentials be stolen and resold to someone in different timezone)

Converts Spotify playlist from "Song Links" list:

    https://open.spotify.com/track/6autdCG3xl7gzoiDCEB2HN
    https://open.spotify.com/track/4q6RvRkXquQ965hubV58lb
    https://open.spotify.com/track/01pzLOA8rQLfoodUCLc2wj

To "Track - Artist" list:

    Nerevar Rising - Jeremy Soule
    Arcanum - NewEnglandStringQuartet
    Wilderness - Matt Uelmen    

Requirements
------------
    sudo apt-get install jq

Usage
------------
1. Open Spotify app
2. Open playlist or "Songs" view
3. Select all tracks `Ctrl+A`
4. Copy track urls `Ctrl+C`
5. Paste into file and save
6. `cat /path/to/file | ex-spotify-playlist.sh`
<hr/>

# [ec2ssh.sh](https://github.com/dmi3/bin/blob/master/ec2ssh.sh)


Decription
----------
* Writes all running AWS EC2 instances with defined name to [SSH config file](https://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/)
* So you write `ssh instance_name` instead of `ssh -i ~/.ssh/gate.pem ec2-user@ec2-12-345-67-89.us-east-1.compute.amazonaws.com`
* Autocompletion!
* Command history is clean and reusable for `ssh` and `scp`
* Instance IP change on reboot is not problem anymore
* Works well with [sssh2](https://github.com/dmi3/bin/blob/master/sssh2).

Instalation
-----------
* Setup [aws-cli](https://github.com/aws/aws-cli#aws-cli)
* (Optional) Install [latest Openssh in 16.04](https://gist.github.com/stefansundin/0fd6e9de172041817d0b8a75f1ede677)
* Change credentials in `TEMPLATE` ↓

Usage
-----
* If you have Openssh > 7.3:
  - `ec2ssh.sh | tee ~/.ssh/aws_config`
  - Add [Include aws_config](https://superuser.com/a/1142813) to `~/.ssh/config`
* Else (will overwrite file)
  - ec2ssh.sh | tee ~/.ssh/config
<hr/>

# [duplicati-ping.py](https://github.com/dmi3/bin/blob/master/duplicati-ping.py)


Decription
-----------
Ping <https://healthchecks.io/> on successful [Duplicati](https://www.duplicati.com/) backup

Usage
-----
Add path to this script to `run-script-after` in job `Configuration` → `Options` → `Advanched Options`
On Windows you will need to create `.bat` file containing path to this script, and add path to `.bat` file to `run-script-after`
<hr/>

# [doom](https://github.com/dmi3/bin/blob/master/doom)


Decription
----------
Script to run gzdoom with various configurations/wads. Selectable via dmenu

Requirements
------------
1. [Get latest Gzdoom](http://debian.drdteam.org/)
2. `sudo apt-get install gzdoom dmenu python3 python3-setuptools
3. `sudo easy_install3 sh`

Usage
-----
doom
<hr/>

# [control-panel](https://github.com/dmi3/bin/blob/master/control-panel)


Description
-----------
GUI LXQT Settings menu

Requirements
------------
     fzf

Usage
------------
    control-panel
<hr/>

# [config/lxterminal/lxterminal.conf](https://github.com/dmi3/bin/blob/master/config/lxterminal/lxterminal.conf)

Config for [LXTerminal](https://wiki.lxde.org/en/LXTerminal) with copy/paste on Ctrl+C/V and nicer color theme
<hr/>

# [config/kitty/kitty.conf](https://github.com/dmi3/bin/blob/master/config/kitty/kitty.conf)

Config for [Kitty](https://sw.kovidgoyal.net/kitty/) with custom hotkeys, nicer color scheme and some useful tweaks
Refer to [original documentation](https://sw.kovidgoyal.net/kitty/conf.html) for more options
<hr/>

# [config/fish/config.fish](https://github.com/dmi3/bin/blob/master/config/fish/config.fish)

Fish config with awesome flexible prompt, unicode symbols, better fzf integration and tons of handy functions.
<hr/>

# [config/clipit/clipitrc](https://github.com/dmi3/bin/blob/master/config/clipit/clipitrc)

Config for [ClipIt](https://github.com/CristianHenzel/ClipIt) with sane defaults and hotheys
<hr/>

# [center-mouse-active-window.py](https://github.com/dmi3/bin/blob/master/center-mouse-active-window.py)


Decription
-----------
Moves mouse in the center of active window.

Requirements
------------
    sudo apt-get install xdotool python3-sh gir1.2-wnck-3.0

Usage
-----
center-mouse-active-window.py
<hr/>

# [bookmarks](https://github.com/dmi3/bin/blob/master/bookmarks)


Decription
----------
Script for quickly adding and accessing bookmarks. Browser independent.
When you want to store bookmarks in plain format, use CLI, but don't want use [bm](https://github.com/tj/bm) 
or [Buku](https://github.com/jarun/Buku)
Useful when set by hotkeys or [clipboard manager](https://developer.run/25) actions.

Requirements
----------
1. `sudo apt-get install fzf`

Usage
-----
* `bookmarks -a http://github.com useful site`
* `bookmarks -a %s $(zenity --entry)` Interactive
* `bookmarks`
* Bookmark currently copied link using [ClipIt](https://github.com/CristianHenzel/ClipIt) actions: `bookmarks -a %s $(zenity --entry)`
<hr/>

# [battery](https://github.com/dmi3/bin/blob/master/battery)


Description
----------
One more script to show battery status as bar(s). Difference from other solutions:
* Simplicity, duh
* Acknowledges the fact that there were sometimes more than one battery in laptop
  - Will display capacity for all batteries
* Also the fact that there were sometimes no battery at all!
  - No error in this case
* Old batteries usually max at ≈99, so it has same symbol as 100
* Can work with [indicator-sysmonitor](https://github.com/fossfreedom/indicator-sysmonitor)
* [Spark](https://github.com/holman/spark) could be used here, but this solution is even simpler

Usage
-----
    $ battery # multiple batteries are installed
    🔌 ▄▇
    $ battery # single battery is installed
    🔌 ▇
    $ battery # no battery is installed
    🔌
<hr/>

# [batch-rename.py](https://github.com/dmi3/bin/blob/master/batch-rename.py)


Decription
-----------
Renames files given in arguments. Interactively prompts for file name. If no otherwise specified - uses first file
name + number.

Usage
-----
rename.py file1 file2 file3 ...
<hr/>

# [backup_protectedtext.py](https://github.com/dmi3/bin/blob/master/backup_protectedtext.py)


Decription
-----------
* Backup secrets from www.protectedtext.com to local storage
* If file is changed, keep previous version with date postfix
* Only backups once per day
* Can be decrypted using `base64 -d BACKUP_FILE | openssl aes-256-cbc -d -k PASSWORD`
* More info <http://developer.run/13>

Usage
-----
Run from commandline or add to cron
<hr/>

# [aliases.bash](https://github.com/dmi3/bin/blob/master/aliases.bash)


Decription
-----------
Some handy bash aliases and settings.
⚠ You may find more useful commands in [Fish shell aliases](https://github.com/dmi3/fish#aliasesfish) (which is easily portable to Bash)


Usage
-----
1. `wget https://raw.githubusercontent.com/dmi3/bin/aliases.bash --no-check-certificate -O ~/bin/aliases.bash`
2. `echo "source ~/bin/aliases.bash" >> ~/.bashrc`
3. To make bash more usable you probably want to install https://github.com/mrzool/bash-sensible
4. To make this work across remote machines, you also may want to install https://github.com/Russell91/sshrc 
<hr/>
