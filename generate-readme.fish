#!/usr/bin/fish

#  Decription
#  ----------
#  Generates this readme

#  Usage
#  -----
#       echo -e "#!/bin/sh\necho \# Useful scripts for Linux users > README.md\necho \"See my [Fish config](https://github.com/dmi3/fish) for more CLI awesomness\" >> README.md\ngenerate-readme.fish --reverse >> README.md\nshasum -a 256 * | grep -v 'SHASUMS\|config' > SHASUMS" > .git/hooks/pre-commit
#       chmod +x .git/hooks/pre-commit    


if [ "$argv[1]" = "--reverse" ]
  set FILTER tac
else
  set FILTER cat
end

for f in (git ls-files "*[^.md|^.txt]" | $FILTER)
    echo -e "\n# [$f](https://github.com/dmi3/"(basename (pwd))"/blob/master/$f)\n"    
    grep -h -e "#\s\s" $f | grep -v "Author\|Source" | string sub -s 4 | string replace -ar "(?=Usage|Requirements|Instalation|Decription|Description)" "\n"
    cat $f | grep -e "^function" | string replace 'function ' '* `' | string replace ' --description' '`'
    echo -e "<hr/>"    
end

git add README.md
