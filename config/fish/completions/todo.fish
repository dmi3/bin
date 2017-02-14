#  Decription
#  ----------
#  Auto generate completion for [todo](https://github.com/dmi3/bin/blob/master/todo) script.
#  Search script for strings starting with `--` and add them
#  to Fish completion as arguments for `todo` command

complete -c todo --no-files

for arg in (grep -oe "\"\-\-\w*\"" (which todo))
    complete -c todo -a $arg
end