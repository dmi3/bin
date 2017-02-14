#!/usr/bin/fish

echo "# Useful scripts for Linux users"    

for f in (git ls-files "*[^.md]")
    echo -e "\n# [$f](https://github.com/dmi3/bin/blob/master/$f)\n"    
    grep -h -e "#\s\s" ~/bin/$f | grep -v "Author\|Source" | string sub -s 4
    echo -e "<hr/>"    
end