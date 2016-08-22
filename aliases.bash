#  Decription
#  ===========
#  Some handy bash aliases

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Requirements
#  ============
#  sudo apt-get install twistd pm-utils

#  Usage
#  =====
#  wget https://raw.githubusercontent.com/dmi3/bin/aliases.bash --no-check-certificate -O ~/bin/aliases.bash
#  echo "source ~/bin/aliases.bash" >> ~/.bashrc
#  To make bash more usable you probably want to install https://github.com/mrzool/bash-sensible
#  To make this work across remote machines, you also may want to install https://github.com/Russell91/sshrc 

# Resolve aliases after sudo
alias sudo='sudo '

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

setup-bash() {
   wget https://raw.githubusercontent.com/mrzool/bash-sensible/master/sensible.bash --no-check-certificate -O ~/bin/sensible.bash
   /usr/bin/grep -q -F 'source ~/bin/sensible.bash' ~/.bashrc || echo "source ~/bin/sensible.bash" >> ~/.bashrc
   wget https://raw.githubusercontent.com/dmi3/bin/master/aliases.bash --no-check-certificate -O ~/bin/aliases.bash
   echo "source ~/bin/aliases.bash" >> ~/bin/sensible.bash
   # Do not trim long paths in the prompt
   echo "PROMPT_DIRTRIM=0" >> ~/bin/sensible.bash
   # Send terminate on Ctrl+Shift+C to free Ctrl+C for copy
   echo "stty intr \^C" >> ~/bin/sensible.bash
   # Setup prompt
   echo "PS1=\"\[$(tput bold)\]\[\033[38;5;243m\][\w❯\n$ \[$(tput sgr0)\]"\" >> ~/bin/sensible.bash
}
