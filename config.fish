function fzf-history-widget
    history | fzf --prompt="⌕ " -e +s +m --tiebreak=index --toggle-sort=ctrl-r --sort > /tmp/fzf.result
    and commandline (cat /tmp/fzf.result)
    commandline -f repaint
    commandline -f  execute
    rm -f /tmp/fzf.result
end

function fish_user_key_bindings
	  # Clear input on Ctrl+U
    bind \cu 'commandline "";'
    
    # Simulate Ctrl+R in Bash    
    if [ (which fzf)!="" ]
      # Use fzf if installed
      bind \cr fzf-history-widget
    else
      bind \cr history-search-backward
    end      

    # Send terminate on Ctrl+Shift+C to free Ctrl+C for copy
    stty intr \^C
end

function fish_prompt
    set_color 777 --bold
    echo -n [(pwd)❯
    set_color A6E22E

    # Git stuff
    if [ "true" = (git rev-parse --is-inside-work-tree ^ /dev/null; or echo false) ]
        echo -n ' ⌥'(git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
        set __unpushed_commits (git cherry -v | wc -l)
        if [ $__unpushed_commits !=  "0" ]
            echo -n (set_color F92672)' ⬆'(git cherry -v | wc -l)''
        end
    end
    
    echo
    echo (set_color 777)'➤ '
end

# Show next and previous months in cal
alias cal="ncal -bM3"

# Create missing directories
alias mkdir='mkdir -pv'

# Print full file path
alias path='readlink -e'

# Human readable sizes (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -g'

# Create and cd to directory
function mkcd
  mkdir $argv
  and cd $argv
end

# Reset window size and bring it to main monitor. Useful if DE messes up
function reset_window
  wmctrl -r $argv -e 0,0,0,800,600
  wmctrl -a $argv
end

# Prepend `sudo` to `nano` command if file is not editable by current user
function nano
  if test -w "$argv"
    /bin/nano $argv
  else
    sudo /bin/nano $argv
  end
end

# If Sublime Text installed - use it instead of Gedit
if [ (which subl)!="" ]
  alias gedit=subl
end

alias poweroff='shutdown -P now'
alias reboot='shutdown -r now'  

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
