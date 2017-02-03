#  Decription
#  ----------
#  Fish config with awesome prompt, unicode symbols, better fzf integration and lot of handy functions.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Instalation
#  ----------
#  [Install fish](http://fishshell.com/#platform_tabs)
#  curl https://raw.githubusercontent.com/dmi3/bin/master/config.fish --create-dirs -o ~/.config/fish/config.fish
#  fish -c update-fzf

#
# Fish config
#

function fish_user_key_bindings
	  # Clear input on Ctrl+U
    bind \cu 'commandline "";'
    
    # Simulate Ctrl+R in Bash    
    if type -q fzf
      # Use fzf if installed
      bind \cr fzf-history-widget

      # Fuzzy search & append filename to current commandline
      bind \ce search
    else
      # Use poor man completion (as up arrow, without search-as-you-type)
      echo "⚠ fzf is not installed. To greatly improve Ctrl+R and Ctrl+E type `update-fzf`"
      bind \cr history-search-backward
    end      

    # Send terminate on Ctrl+Shift+C to free Ctrl+C for copy (in terminal settings).
    stty intr \^C
end

function fish_prompt
    set_color 777 --bold
    echo -n [(pwd)❯
    
    # Git stuff
    set __git_branch (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    if [ $__git_branch!="" ]
        set_color A6E22E
        echo -n ' ⌥'$__git_branch
        set __git_unpushed_commits (git cherry -v | wc -l)
        if [ $__git_unpushed_commits !=  "0" ]
            set_color F92672
            echo -n ' ⬆'$__git_unpushed_commits
        end
    end
    
    echo
    echo (set_color 777)'➤ '
end

# Disable greeting
set -u fish_greeting

#
# Useful aliases
#

# Show 3 (next and prev) months in cal, start week on monday
alias cal="ncal -bM3"

# Create missing directories in path
alias mkdir='mkdir -pv'

# Print full file path
alias path='readlink -e'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -m'

alias poweroff='shutdown -P now'
alias reboot='shutdown -r now'

# Useful for piping, i.e. `cat ~/.ssh/id_rsa.pub | copy`
alias copy='xclip -sel clip'

function mkcd --description "Create and cd to directory"
  mkdir $argv
  and cd $argv
end

alias git-show-unpushed-commits='git cherry -v' 

#
# Fzf stuff (https://github.com/junegunn/fzf)
#

set -x FZF_DEFAULT_OPTS --prompt="⌕ "

function fzf-history-widget
    history | fzf -q (commandline) -e +s +m --tiebreak=index --toggle-sort=ctrl-r --sort | read -l result; and commandline $result
    commandline -f repaint
    commandline -f execute
end

function search --description "Search files by mask, case insensitive, output with full path"
  if [ $argv == ""]
    find $PWD 2>/dev/null | fzf | read -l result; and commandline -a $result
  else
    find $PWD -iname $argv 2>/dev/null  | fzf
  end    
end

function update-fzf --description "Installs or updates fzf"
  set FZF_VERSION (curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/junegunn/fzf-bin/releases/latest | xargs basename)
  curl -L https://github.com/junegunn/fzf-bin/releases/download/$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tgz | tar -xz -C /tmp/
  sudo -p "Root password to install fzf: " mv /tmp/fzf-$FZF_VERSION-linux_amd64 /usr/bin/fzf
end

function search-gui --description "Search files, and open directory in GUI File Manager. Useful in File Mangagers that lack search-as-you-type"
  find $PWD 2>/dev/null | fzf | read -l result; and open (dirname $result) &
end

#
# Util improvements
#

function reset_window --description  "Reset window size and bring it to main monitor. Useful if DE messes up in multiple monitor configuration"
  wmctrl -r $argv -e 0,0,0,800,600
  wmctrl -a $argv
end

# Prepend `sudo` to `nano` command if file is not editable by current user
# Warn if file does no exist
function nano
  if not test -e "$argv"
    read -p "echo 'File $argv does not exist. Ctrl+C to cancel'" -l confirm
    touch "$argv" 2>/dev/null
  end

  if test -w "$argv"    
    /bin/nano -mui $argv
  else
    echo "Editing $argv requires root permission"
    sudo /bin/nano -mui $argv
  end
end

function run --description "Make file executable, then run it"
  chmod +x "$argv"
  eval "./$argv"
end

function b --description "Exec command in bash. Useful when copy-pasting commands with imcompatible syntax to fish "
  bash -c "$argv"
end

# If Sublime Text installed - use it instead of Gedit
if type -q subl
  alias gedit=subl
end

function subl --description "Starts Sublime Text. Additionally supports piping (i.e. `ls | subl`) and urls (i.e. `subl http://jenkins/logs`)"
  if [ (expr substr "$argv[1]" 1 4) = "http" ]
    curl $argv[1] | subl
  else if not tty >/dev/null
    set FILENAME (tempfile)
    cat >"$FILENAME"
    /opt/sublime_text/sublime_text "$FILENAME" "$argv"
  else
    /opt/sublime_text/sublime_text "$argv"
  end
end

#
# Web services
#

# Shows external ip
alias myip='curl ifconfig.co'

# Like whoami but shows your external ip and geolocation
alias whereami='curl ifconfig.co/json'

function random-name
  curl www.pseudorandom.name
end

function random-email --description "Copy random email in one of Mailinator subdomains and provide link to check it"
  set domain (echo -e \
"notmailinator.com
veryrealemail.com
chammy.info
tradermail.info
mailinater.com
suremail.info
reconmail.com" | shuf -n1)
  set email (curl -s www.pseudorandom.name | string replace ' ' '')@$domain
  printf "$email" | tee /dev/tty | xclip -sel clip
  echo -e "\ncopied to clipboard\nhttps://www.mailinator.com/inbox2.jsp?public_to=$email"
end 

function random-password --description "Generate random password" --argument-names 'length'
  test -n "$length"; or set length 13
  head /dev/urandom | tr -dc "[:graph:]" | head -c $length | tee /dev/tty | xclip -sel clip; and echo -e "\ncopied to clipboard"
end

function weather --description "Show weather"
  resize -s $LINES 125
  curl wttr.in/$argv
end

function xsh --description "Prepend this to command to explain its syntax i.e. `xsh iptables -vnL --line-numbers`"
  w3m -o confirm_qq=false "http://explainshell.com/explain?cmd=$argv"
  # replace w3m to any browser like chrome
end

function transfer --description "Upload file to transfer.sh"
  curl --progress-bar --upload-file $argv https://transfer.sh/(basename $argv)   
end

#sudo apt-get install libtranslate-bin
function tru
  echo "$argv" | translate-bin -s google -t ru
end

function ten
  echo "$argv" | translate-bin -s google -f ru -t en
end


#
# Color configuration
# https://github.com/benmarten/Monokai_Fish_OSX/blob/master/set_colors.fish
# https://fishshell.com/docs/current/index.html#variables-color

set fish_color_normal F8F8F2 # the default color
set fish_color_command F8F8F2 # F92672 # the color for commands
set fish_color_quote E6DB74 # the color for quoted blocks of text
set fish_color_redirection AE81FF # the color for IO redirections
set fish_color_end F8F8F2 # the color for process separators like ';' and '&'
set fish_color_error F8F8F2 --background=F92672 # the color used to highlight potential errors
set fish_color_param FD971F # A6E22E # the color for regular command parameters
set fish_color_comment 75715E # the color used for code comments
set fish_color_match F8F8F2 # the color used to highlight matching parenthesis
set fish_color_search_match --background=49483E # the color used to highlight history search matches
set fish_color_operator FD971F # AE81FF # the color for parameter expansion operators like '*' and '~'
set fish_color_escape 66D9EF # the color used to highlight character escapes like '\n' and '\x70'
set fish_color_cwd 66D9EF # the color used for the current working directory in the default prompt
