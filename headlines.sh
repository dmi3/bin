#!/bin/bash

#  Decription
#  -----------
#  Prints top headlines from Hacker News. See <http://developer.run/27>.
#  Additionally prints latest @sadserver tweet for cynical comments.

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)
  
#  Requirements
#  ------------
#      sudo apt-get install jq

#  Usage
#  ------------
#  ⚠ You need `chmod 777 /var/run/motd.dynamic` on boot or use `root`
#
#  * `headlines.sh > /var/run/motd.dynamic`
#  * OR `crontab -e`; `0 */2 * * * /path/to/headlines.sh > /var/run/motd.dynamic`
#  * OR <https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/>

SINCE=$(date --date="5 days ago" +%s)
MAX=3
THRESHOLD=1000
echo " 📰 HEADLINES $(date '+%Y/%m/%d %H:%S')"
curl -s "https://hn.algolia.com/api/v1/search_by_date?numericFilters=points>$THRESHOLD,created_at_i>$SINCE&hitsPerPage=$MAX" \
 | jq -r "if .nbHits == 0 then \"No news is good news\" else .hits[].title end"

# Get latest @sadserver tweet
# Yep, it pipes `twitter.com → twitrss.me → rss2json.com` to bypass Twitter 1.1 API authentication

TODAY=$(date +%Y-%m-%d)
curl -s "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Ftwitrss.me%2Ftwitter_user_to_rss%2F%3Fuser%3Dsadserver" \
    | jq -r ".items[] | select(.pubDate | contains(\"$TODAY\")) | \"\n@sadserver: \" + .title"