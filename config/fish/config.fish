#  ----------
#  Fish config with awesome flexible prompt, unicode symbols, better fzf integration and lot of handy functions.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Instalation
#  ----------
#  1. [Install fish](http://fishshell.com/#platform_tabs)
#  2. `curl https://raw.githubusercontent.com/dmi3/bin/master/config/fish/config.fish --create-dirs -o ~/.config/fish/config.fish`
#  3. `fish -c update-fzf`


#
# Fish config
# https://fishshell.com/docs/current/

# https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish
# fish_key_reader
function fish_user_key_bindings
	  # Clear input on Ctrl+U
    bind \cu 'commandline "";'
    
    if type -q fzf # Use fzf if installed
      # Simulate Ctrl+R in Bash      
      bind \cr fzf-history-widget

      # Fuzzy recursive search files in current directory & append selection to current command
      bind \cf search
      
      # Most frequently visited directories on Ctrl+E
      bind \ce scd
      
      bind \e\cf search-contents
    else # Use poor man completion (as up arrow, without search-as-you-type)
      echo "⚠ fzf is not installed. To greatly improve Ctrl+R, Ctrl+E, Ctrl+Alt+F and Ctrl+F type `update-fzf`"
      bind \cr history-search-backward
    end

    # Navigation with Alt+Ctrl ↑→←
    bind \e\[1\;7D "set __ignore_dir_history 1; prevd; echo; commandline -f repaint;"
    bind \e\[1\;7C "set __ignore_dir_history 1; nextd; echo; commandline -f repaint;"
    bind \e\[1\;7A "set __ignore_dir_history 1; cd ..; echo; commandline -f repaint;"
    bind \e\[1\;7B "set __ignore_dir_history 1; prevd; echo; commandline -f repaint;"

    math (echo $version | tr -d .)"<231" > /dev/null; and echo "⚠ Please upgrade Fish shell to at least 2.3.0 https://fishshell.com/#platform_tabs"

    # Send terminate on Ctrl+Shift+C to free Ctrl+C for copy (in terminal settings).
    stty intr \^C
end

function fish_prompt
    set_color 777 --bold

    set __git_branch (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    
    # Full path + git trimmed to width of terminal
    set prompt_width (math (pwd | string length) + (string length "$__git_branch") + 7)
    if test $prompt_width -gt $COLUMNS
      echo -n […(pwd | string sub -s (math $prompt_width - $COLUMNS + 4))"❯ "
    else
      echo -n [(pwd)"❯ "
    end
    
    # Git stuff    
    if [ $__git_branch!="" ]
        set_color A6E22E
        echo -n '⌥'$__git_branch
        set __git_unpushed_commits (git cherry -v | wc -l)
        if [ $__git_unpushed_commits !=  "0" ]
            set_color F92672
            echo -n " ⬆$__git_unpushed_commits "
        end
    end

    echo
    echo (set_color 777)'➤ '
end

function show_exit_code --on-event fish_postexec --description "Show exit code on command failure"
    set -l last_status $status
    if [ $last_status -ne 0 -a $argv != "" ]
      echo (set_color F92672)"✖ $last_status"
    end  
end

function spwd --on-variable PWD --description "Use fish as file manager. ls on directory change"
  echo (set_color -d FFFFFF)
  ls $PWD
  test -n "$__ignore_dir_history"; or pwd >> ~/.local/share/fish/fish_dir_history
  set -e __ignore_dir_history  
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

# Remove directories but ask nicely
alias rmm='rm -rvI'

# add current directory to path
alias add-to-path='set -U fish_user_paths (pwd) $fish_user_paths'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -m'

# Ask password when working with docker https://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-users-run-docker-in-centos-fedora-or-rhel/
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'

alias ...='cd ../..'

alias sizeof="du -hs"

alias git-show-unpushed-commits='git cherry -v' 

function ll --description "Scroll ll if theres more files that fit on screen"
  ls -l $argv --color=always | less -R -X -F
end  

function git-revert-file --description "Revert single file in git"
  git reset HEAD $argv; git checkout $argv
end

function mkcd --description "Create and cd to directory"
  mkdir $argv
  and cd $argv
end

function open --description "Open file in new process"
  xdg-open $argv &
end

# function aunpack --description "Unpack archive"
#   aunpack "$argv" --save-outdir=/tmp/___aaaunpack
#   cd (cat /tmp/___aaaunpack)
# end

function amount --description "Mount archive"
  /usr/lib/gvfs/gvfsd-archive file=$argv 2>/dev/null &
  sleep 1
  cd $XDG_RUNTIME_DIR/gvfs  
  cd (ls -p | grep / | tail -1) # cd last created dir
end

function aumount --description "Unmount all mounted archive (and gvfs locations)"
  gvfs-mount --unmount $XDG_RUNTIME_DIR/gvfs/*
end

# Useful for piping, i.e. `cat ~/.ssh/id_rsa.pub | copy`
# If arguments are given, copies it to clipboard
function copy --description "Copy pipe or argument"
  if [ "$argv" = "" ]
    xclip -sel clip
  else
    printf "$argv" | xclip -sel clip
  end    
end

function color --description "Print color"
  echo (set_color (string trim -c '#' "$argv"))"██"
end

#
# Fzf stuff 
# https://github.com/junegunn/fzf
# https://github.com/junegunn/fzf/blob/master/man/man1/fzf.1
#

set -x FZF_DEFAULT_OPTS --prompt="⌕ "

function fzf-history-widget
    history | fzf -q (commandline) -e +s +m --tiebreak=index --toggle-sort=ctrl-r --sort \
      --bind "ctrl-e:execute(echo \" commandline {}\")+cancel+cancel" \
      --bind "ctrl-d:execute(echo \" history delete {}\")+cancel+cancel" \
      --bind "ctrl-x:execute(echo \" printf {} | xclip -sel clip\")+cancel+cancel" \
      --header "Enter to exec, Ctrl+X to copy, Ctrl+E to edit, Ctrl+D to delete" | read -l result
    and commandline $result
    and commandline -f repaint
    and commandline -f execute
end

function search --description "Search files by mask, case insensitive, output with full path"
  if [ $argv == ""]
    find $PWD 2>/dev/null | fzf -q "'" \
      --bind "ctrl-f:execute(echo -e \" search-contents\n\")+cancel+cancel" | read -l result; and commandline -a $result
  else
    find $PWD -iname $argv 2>/dev/null  | fzf      
  end    
end

function search-contents --description "Search file contents"
  if type -q ag
    ag --nobreak --no-numbers --noheading --max-count 100000 . 2>/dev/null \
        | fzf \
          -q "'" \
          --header 'Searching file contents' \
          --preview-window 'up:3:wrap' \
          --preview 'echo {} | cut -d ":" -f2' \
        | string split ':' | head -n 1 | read -l result
    and commandline $result
    and commandline -f repaint
  else
    echo "⚠ to speed up search install ag"
    grep -I -H -n -v --line-buffered --color=never -r -e '^$' . | fzf | string split ":" | head -n 1 | read -l result
    and commandline $result
    and commandline -f repaint
  end
end

function scd
    cat ~/.local/share/fish/fish_dir_history | freq | fzf -q "'" -e +s +m --tiebreak=index --toggle-sort=ctrl-r --sort | cut -c9- | read -l result
    and cd $result
    and commandline -f repaint
    and ls
end

function search-gui --description "Search files, and open directory in GUI File Manager. Useful in File Mangagers that lack search-as-you-type"
  find $PWD 2>/dev/null | fzf | read -l result; and open (dirname $result) &
end

function update-fzf --description "Installs or updates fzf"
  set FZF_VERSION (curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/junegunn/fzf-bin/releases/latest | xargs basename)
  curl -L https://github.com/junegunn/fzf-bin/releases/download/$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tgz | tar -xz -C /tmp/
  sudo -p "Root password to install fzf: " mv /tmp/fzf /usr/local/bin/fzf
end

#
# Util improvements
#

function reset_windows --description  "Reset all windows size and bring it to main monitor. Useful if DE messes up in multiple monitor configuration"
  for f in (wmctrl -l | cut -d' ' -f 1)
    wmctrl -i -r $f -e 0,0,0,800,600
    wmctrl -i -a $f
  end
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
  head /dev/urandom | tr -dc "[:alnum:]~!#\$%^&*-+=?./|" | head -c $length | tee /dev/tty | xclip -sel clip; and echo -e "\ncopied to clipboard"
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

# https://github.com/dmi3/bin/blob/master/yandex-translate.sh
function translate
  translate-yandex.sh "$argv"
end

# https://gist.github.com/rsvp/1859875
function freq --description "Line frequency in piped input"
  cat 1>| sort -f | uniq -c | sort -k 1nr -k 2f
end

function rangr 
  rm /tmp/rangr 2> /dev/null; or true

  ranger

  if [ -f /tmp/rangr ]
    if test -d (cat /tmp/rangr)
      cd (cat /tmp/rangr)
      commandline -f repaint
    else if test -e (cat /tmp/rangr)
        commandline (cat /tmp/rangr)
    end
  end
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
