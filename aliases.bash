#  Decription
#  ===========
#  Some handy bash aliases

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ============
#  sudo apt-get install twistd

#  Usage
#  =====
#  wget https://raw.githubusercontent.com/dmi3/bin/aliases.bash --no-check-certificate -O ~/bin/aliases.bash
#  echo "source ~/bin/aliases.bash" >> ~/.bashrc
#  To make bash more usable you probably want to install https://github.com/mrzool/bash-sensible
#  To make this work across remote machines, you also may want to install https://github.com/Russell91/sshrc 

# Aliases
mkcd () {
  mkdir "$1"
  cd "$1"
}

# Open file in GUI associated application
alias open=xdg-open

alias ll='ls -l'

# Serves current directory on 8080 port
alias server-here='twistd -no web --path=.'

# Defaults

alias wget='wget --no-check-certificate'

# Grep ignoring case and regexp
alias grep='grep -i -E'

# Create missing directories
alias mkdir='mkdir -pv'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -g'

# Adding repositories without prompt, automatically adding sudo
add-apt-repository() {
    sudo add-apt-repository --yes $*
    sudo apt-get update
}    

if [ $UID -ne 0 ]; then
    alias susp='sudo /usr/sbin/pm-suspend'
    alias poweroff='sudo poweroff'
    alias reboot='sudo reboot'
    alias apt-get='sudo apt-get'
fi
