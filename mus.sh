#!/bin/bash

#  Decription
#  ----------
#  Setups MUS (Minimal Usable System). Targets very slow machines with very broken disks and very bad internet, so checks everything.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#      /usr/bin/GET https://raw.githubusercontent.com/dmi3/bin/master/mus.sh > ~/mus.sh && chmod +x ~/mus.sh && ~/mus.sh

#SIZE=wget --spider https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/debian-live-10.0.0-amd64-lxde.iso 2>&1 | grep Length | cut -d ' ' -f 2
#SIZE=stat -c '%s' imagename.iso 
SIZE=2349416448

#MD5SUM=curl -s https://cdimage.debian.org/debian-cd/current-live/amd64/bt-hybrid/MD5SUMS | grep lxde.iso | cut -d ' ' -f 1
MD5SUME="bd025c7ac8556055d7766be8cab5b479  -"

#lsblk | grep RM=1
echo "Checking image md5sum"
MD5SUMA=$(sudo head -c $SIZE /dev/sr0 | md5sum)

test "$MD5SUME" = "$MD5SUMA" && echo "ok" || echo "Not ok. Expected '$MD5SUME' Got '$MD5SUMA'"
read -p "Continue? (or Ctrl+C)"

sudo apt-get update
sudo apt-get install curl wget bash-completion firefox-esr encfs 
sudo apt-get install hplip

killall clipit
wget -q --show-progress https://raw.githubusercontent.com/dmi3/bin/master/config/clipit/clipitrc -O ~/.config/clipit/clipitrc
nohup clipit&

wget -q --show-progress https://raw.githubusercontent.com/dmi3/bin/master/config/lxterminal/lxterminal.conf -O ~/.config/lxterminal/lxterminal.conf
wget -q --show-progress https://raw.githubusercontent.com/dmi3/bin/master/aliases.bash -O ~/aliases.bash
wget -q --show-progress https://raw.githubusercontent.com/dmi3/bin/master/layoutset -O ~/layoutset
wget -q --show-progress https://github.com/keepassxreboot/keepassxc/releases/download/2.4.3/KeePassXC-2.4.3-x86_64.AppImage

wget -q --show-progress https://raw.githubusercontent.com/dmi3/bin/master/MD5SUMS -O /tmp/SHASUMS
wget -q --show-progress https://github.com/keepassxreboot/keepassxc/releases/download/2.4.3/KeePassXC-2.4.3-x86_64.AppImage.DIGEST -O ->> /tmp/SHASUMS
sha256sum -c --ignore-missing /tmp/SHASUMS
read -p "Continue? (or Ctrl+C)"

echo "source ~/aliases.bash" >> ~/.bashrc
chmod +x KeePassXC-*-x86_64.AppImage

~/layoutset

echo "You can restart terminal now"
