# Auto generate completion for `todo` script.
# Search script for strings starting with -- and add them
# to Fish completion as arguments for `todo` command

complete -c todo --no-files

for arg in (grep -oe "\"\-\-\w*\"" (which todo))
    complete -c todo -a $arg
end