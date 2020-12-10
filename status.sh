#!/bin/bash

#  Description
#  -----------
#  ![Status](https://developer.run/pic/status.png)
#  CLI Status dashboard. Visualizes your GitHub and Twitter followers, and last 5000 blog hits. Works well with [headlines.sh](https://github.com/dmi3/bin) and `newsbeuter -x reload -x print-unread 2> /dev/null` [Read more](https://developer.run/51)

  
#  Requirements
#  ------------
#  * [spark](https://github.com/holman/spark)
#  * sudo apt-get install jq
#      # install 

#  Usage
#  ------------
   
#  * `status.sh`

# echo -e "\n ★ Github"
# curl -s https://api.github.com/users/dmi3/repos | jq -r "sort_by(.stargazers_count) | . [] | select(.stargazers_count!=0 or .forks!=0) | [.html_url, .stargazers_count, .forks] | @csv" | column -s, -t
# curl -s https://api.github.com/users/dmi3 | jq -r .followers | awk '{print $0, "followers"}'

# echo -e "\n 🐦 Twitter"
#  curl -s "https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=dmi0x3" | jq -r ".[] .formatted_followers_count"



echo -e "\n 📈 Blog"
BLOG_STATS=$(curl -s -H "X-Parse-Application-Id: H0H193qDKFgdP5WZMObYL7W3Y4XHCBDxPSxPKI6C" -H "X-Parse-Master-Key: $PARSE_MASTER_KEY" -G --data-urlencode 'order=-createdAt' --data-urlencode 'limit=5000' https://parseapi.back4app.com/classes/Visitor) 

echo "$BLOG_STATS" | jq -r ".results | group_by(.createdAt[0:10])[] | [group_by(.token)[]] | length " | spark
echo "$BLOG_STATS" | jq -r ".results | group_by(.createdAt[0:10])[] | [group_by(.token)[]] | [.[0][0].createdAt[0:10], length, (flatten | length), ([flatten | .[] | .country] | unique | join(\" \"))] | @csv" | column -s, -t
