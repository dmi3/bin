#!/usr/bin/fish

#  Decription
#  ----------
#  Generates this readme

#  Usage
#  -----
#  echo "#!/bin/sh\necho gen readme\nfish generate-readme.fish > README.md" > .git/hooks/pre-commit


echo "# Useful scripts for Linux users"    

for f in (git ls-files "*[^.md|^.txt]")
    echo -e "\n# [$f](https://github.com/dmi3/bin/blob/master/$f)\n"    
    grep -h -e "#\s\s" ~/bin/$f | grep -v "Author\|Source" | string sub -s 4 | string replace -ar "(?=Usage|Requirements|Instalation|Decription)" "\n"
    echo -e "<hr/>"    
end