#!/bin/bash

#  <img src="https://developer.run/pic/headlines.png"/>
#
#  Description
#  -----------
#  * Prints ground shaking headlines from Hacker News in shell greeting
#  * Don't miss next Meltdown, be notified right away!
#  * Doesn't distract you if nothing important happened
#  * Allows open given news item in browser and mark it as read
#  * Additionally prints latest [@sadserver](https://twitter.com/sadserver) tweet for cynical comment
#  * If you prefer simpler version without additional functionality refer [to initial version](https://github.com/dmi3/bin/blob/2fb9f8a894ea4eba5edb13c7135861740de83084/headlines.sh)
#  * See <http://developer.run/27> for description and more ideas

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)
  
#  Requirements
#  ------------
#      sudo apt-get install jq

#  Usage
#  ------------
   
#  * `headlines.sh` will print latest headlines
#  * `headlines.sh 1` will open first headline url in browser and mark it as read
#    - Note that after that hedline №2 move up to №1
#  * If you want to hide any particular news header add it to `~/.readnews`:
#    - Single `echo "The Header" >> ~/.readnews`
#    - All `headlines.sh >> ~/.readnews`
#  * Add to shell greeting [see screenshot](https://developer.run/pic/headlines.png)
#    - <https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/>
#    - OR `chmod 777 /var/run/motd.dynamic` on boot and `headlines.sh > /var/run/motd.dynamic`
#    - OR `chmod 777 /var/run/motd.dynamic` on boot and put `0 */2 * * * /path/to/headlines.sh > /var/run/motd.dynamic` to `crontab -e`

SINCE=$(date --date="5 days ago" +%s)
MAX=3
THRESHOLD=1000

touch ~/.readnews
HEADLINES=$(curl -s "https://hn.algolia.com/api/v1/search_by_date?numericFilters=points>$THRESHOLD,created_at_i>$SINCE&hitsPerPage=$MAX" \
 | jq -r "if .nbHits == 0 then \"No news is good news\" else .hits[].title end" | grep -vFf ~/.readnews || echo "All read")

# If argument is given, open n-th item
if [ ! -z "$1" ]; then 
    HEADLINE=$(echo -e "$HEADLINES" | sed -n "$1p")
    test -z "$HEADLINE" && echo "Wrong argument $1" && exit 0
    echo $HEADLINE >> ~/.readnews
    echo "Opening: $HEADLINE"
    xdg-open $(curl -s -G "https://hn.algolia.com/api/v1/search?hitsPerPage=1&" --data-urlencode "query=$HEADLINE" | jq -e -r ".hits[0].url")&
else
    echo " 📰 HEADLINES $(date '+%Y/%m/%d %H:%S')"
    echo -e "$HEADLINES"

    # Get todays @sadserver tweet
    # Yep, it pipes `twitter.com → twitrss.me → rss2json.com` to bypass Twitter 1.1 API authentication

    TODAY=$(date +%Y-%m-%d)
    curl -s "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftwitrss.me%2Ftwitter_user_to_rss%2F%3Fuser%3Dsadserver" \
        | jq -r ".items[] | select(.pubDate | contains(\"$TODAY\")) | \"\n@sadserver: \" + .title"    
fi    