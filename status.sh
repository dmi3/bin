#!/bin/bash

#  Description
#  -----------
#  ![Status](https://developer.run/pic/status.png)
#  
#  CLI Status dashboard. Visualizes GitHub and Twitter followers, and last 500 blog hits. Works well in addition to [headlines.sh](https://github.com/dmi3/bin) and `newsbeuter -x reload -x print-unread 2> /dev/null` [Read more](https://developer.run/51)

  
#  Requirements
#  ------------
#  * [spark](https://github.com/holman/spark) (the other spark, not the huge one)
#  * sudo apt-get install jq

#  Usage
#  ------------
   
#  * Set `PARSE_APP_ID` and `PARSE_MASTER_KEY` variables
#  * `status.sh`

echo -e "\n ★ Github"
curl -s https://api.github.com/users/dmi3/repos | jq -r "sort_by(.stargazers_count) | . [] | select(.stargazers_count!=0 or .forks!=0) | [.html_url, .stargazers_count, .forks] | @csv" | column -s, -t
curl -s https://api.github.com/users/dmi3 | jq -r .followers | awk '{print $0, "followers"}'

echo -e "\n 🐦 Twitter"
 curl -s "https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=dmi0x3" | jq -r ".[] .formatted_followers_count"

test "$PARSE_APP_ID" == ""     && echo "PARSE_APP_ID not set!"
test "$PARSE_MASTER_KEY" == "" && echo "PARSE_MASTER_KEY not set!"

echo -e "\n 📈 Blog"
BLOG_STATS=$(curl -s -H "X-Parse-Application-Id: $PARSE_APP_ID" -H "X-Parse-Master-Key: $PARSE_MASTER_KEY" -G --data-urlencode 'order=-createdAt' --data-urlencode 'limit=500' https://parseapi.back4app.com/classes/Visitor) 

# Visitors diagramm
echo "$BLOG_STATS" | jq -r ".results | group_by(.createdAt[0:10])[] | [group_by(.token)[]] | length " | spark
# Visitors over last 5 days
echo "$BLOG_STATS" | jq -r ".results | group_by(.createdAt[0:10])[] | [group_by(.token)[]] | [.[0][0].createdAt[0:10], length, (flatten | length), ([flatten | .[] | .country] | unique | join(\" \"))] | @csv" | column -s, -t | head -5
# Top 5 pages
echo
echo "$BLOG_STATS" | jq -r '.results | [ group_by(.title)[] | {kw: .[0].title, count: length }] | sort_by(.count) | reverse [] | [.kw, .count] | @csv' | head -5
# Top 5 refferers
echo
echo "$BLOG_STATS" | jq -r ".results | [ .[] | select( .ref != \"\" ) ] | [ group_by(.ref)[] | {kw: .[0].ref, count: length }] | sort_by(.count) | reverse [] | [.kw, .count] | @csv" | head -5
