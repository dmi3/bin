#!/bin/bash

#  <img src="https://developer.run/pic/headlines.png"/>
#
#  Description
#  -----------
#  * Prints ground shaking headlines from Hacker News in shell greeting
#  * Don't miss next Meltdown, be notified right away!
#  * Doesn't distract you if nothing important happened
#  * Allows open all news in browser and mark it as read
#  * If you prefer simpler version without additional functionality refer [to initial version](https://github.com/dmi3/bin/blob/2fb9f8a894ea4eba5edb13c7135861740de83084/headlines.sh)
#  * See <http://developer.run/27> for description and more ideas

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)
  
#  Requirements
#  ------------
#      sudo apt-get install jq

#  Usage
#  ------------
   
#  * `headlines.sh` will print latest headlines
#  * `headlines.sh read` will open all news in browser and mark it as read (hide)
#    - `~/.readnews` stores titles and urls of read news
#    - `~/.readnews` might be useful if you want to find article later
#    - `~/.readnews` might be synced between computers
#  * `headlines.sh clear` will mark all news as read (hide)
#  * Add to shell greeting [see screenshot](https://developer.run/pic/headlines.png)
#    - <https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/>
#    - OR `chmod 777 /var/run/motd.dynamic` on boot and `headlines.sh > /var/run/motd.dynamic`
#    - OR `chmod 777 /var/run/motd.dynamic` on boot and put `0 */2 * * * /path/to/headlines.sh > /var/run/motd.dynamic` to `crontab -e`
#    - To read and update greeting use `headlines.sh read > /var/run/motd.dynamic && clear`    

SINCE=$(date --date="5 days ago" +%s)
MAX=3
THRESHOLD=1000

NEWS=$(curl -s "https://hn.algolia.com/api/v1/search_by_date?numericFilters=points>$THRESHOLD,created_at_i>$SINCE&hitsPerPage=$MAX")
touch ~/.readnews

if [[ "$1" == "read" ]]; then
  echo $NEWS | jq -r '.hits[].url' | grep -vFf ~/.readnews | xargs -L 1 -P $MAX xdg-open >/dev/null 2>&1 &
fi

if [ "$1" == "read" ] || [ "$1" == "clear" ] ; then
  echo $NEWS | jq -r '.hits[] | (.title +"\n" + .url)' | grep -vFf ~/.readnews >> ~/.readnews
fi  

echo " 📰 HEADLINES $(date '+%Y/%m/%d %H:%S')"
echo $NEWS | jq -r "if .nbHits == 0 then \"No news is good news\" else .hits[].title end" | grep -vFf ~/.readnews || echo "All read"

