#  Decription
#  -----------
#  Some handy bash aliases and settings.
#
#  You may find more useful in [Fish shell aliases](https://github.com/dmi3/fish#aliasesfish) (which is easily portable to Bash)

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#  1. `wget https://raw.githubusercontent.com/dmi3/bin/aliases.bash --no-check-certificate -O ~/bin/aliases.bash`
#  2. `echo "source ~/bin/aliases.bash" >> ~/.bashrc`
#  3. To make bash more usable you probably want to install https://github.com/mrzool/bash-sensible
#  4. To make this work across remote machines, you also may want to install https://github.com/Russell91/sshrc 

# Create missing directories in path
alias mkdir='mkdir -pv'

# Print full file path
alias path='readlink -e'

# Remove directories but ask nicely
alias rmm='rm -rvI'

# Copy directories but ask nicely
alias cpp='cp -R'

# add current directory to path
alias add-to-path='set -U fish_user_paths (pwd) $fish_user_paths'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -m'

alias xs='cd'

alias ...='cd ../..'

# Free space on physical drives
alias fs='df -h -x squashfs -x tmpfs -x devtmpfs'

# Lists disks
alias disks='lsblk -o HOTPLUG,NAME,SIZE,MODEL,TYPE | awk "NR == 1 || /disk/"'

# List partitions
alias partitions='lsblk -o HOTPLUG,NAME,LABEL,MOUNTPOINT,SIZE,MODEL,PARTLABEL,TYPE | grep -v loop'

# Size of file or directory
alias sizeof="du -hs"

# Connect to wifi
alias connect=nmtui

# Prevent locking untill next reboot
alias lockblock='killall xautolock; xset s off; xset -dpms; echo ok'

# Save file with provided name
alias wget='wget --content-disposition'

# Resolve aliases after sudo
alias sudo='sudo '

alias ff="find $PWD -iname"
alias untar="tar -vxzf"

alias myip='curl ifconfig.co'
alias getmicro='curl https://getmic.ro | bash && sudo mv ./micro /usr/local/bin/'

# Aliases
mkcd () {
  mkdir "$1"
  cd "$1"
}

# Open file in GUI associated application
alias open=xdg-open

alias ll='ls -lh'

# Serves current directory on 8080 port
alias server-here='twistd -no web --path=.'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -g'

# Adding repositories without prompt, automatically adding sudo
add-apt-repository() {
    sudo add-apt-repository --yes $*
    sudo apt-get update
}   

# Prepend `sudo` to `nano` command if file is not editable by current user
nano() {
  if [ -w "$1" ]
  then
    /bin/nano $*
  else
    sudo /bin/nano $*
  fi
}

# Make file executable, then run it
run() {
  chmod +x "$1"
  exec "./$1" &
}

bak () {
  mv "$1" "$(basename $1).bak"
}

# If Sublime Text installed - use it istead of Gedit
if hash subl 2>/dev/null; then
  alias gedit=subl
fi

# Add sudo if forgotten
if [ $UID -ne 0 ]; then
    alias susp='sudo /usr/sbin/pm-suspend'
    alias apt-get='sudo apt-get'
    alias dpkg='sudo dpkg'
    alias apt='sudo apt'
fi

alias poweroff='shutdown -P now'
alias reboot='shutdown -r now'


# Send terminate on Ctrl+Shift+C to free Ctrl+C for copy
stty intr \^C

# Setup prompt
PS1='\[$(tput bold)\]\[\033[38;5;243m\][\w❯\n$ \[$(tput sgr0)\]'

# History settings
shopt -s histappend
shopt -s cmdhist
HISTSIZE=500000
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
PROMPT_COMMAND='history -a'
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"



