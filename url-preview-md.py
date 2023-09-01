#!/usr/bin/python3

#  Decription
#  -----------
#  Wrapper around [webpreview](https://pypi.org/project/webpreview/). Takes url, downloads a preview image
#  (From open Graph, Twitter, title or image iself, if url points to image) and returns formatted markdown with page title and description.
#  Useful with clipboard manager. [Read more](https://developer.run/70)

#  Requirements
#  ------------
#      pip install webpreview

#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/bin)

#  Usage
#  -----
#      $ url-preview-md.py img_directory url
#      $ url-preview-md.py ~/img http://developer.run/70
#      [Markdown Url Preview](http://developer.run/70) Markdown Url Preview in text editor.
#      ![](/home/dmi3/img/2023_09_01_developer.run_url-preview-md.png)


import os
import sys
import requests
from urllib.parse import urlparse, urljoin
from datetime import datetime
from webpreview import webpreview

d = sys.argv[1]
url = sys.argv[2]

try:
    p = webpreview(url)
except:
    print("Unable to fetch url:" + url)
    exit()

# If link is image - use it
if p.title == None and p.description == None and p.image == None:
    h = requests.head(url)
    content_type = h.headers.get('content-type')
    if content_type.startswith('image/'):
        p.image = url

image = ""
if (p.image):
    try:
        u = p.image
        if not u.startswith("http"):
            u = urljoin(url, p.image)
        r = requests.get(u, allow_redirects=True)
        a = urlparse(url)
        i = urlparse(u)
        filename = "_".join([datetime.now().strftime("%Y_%m_%d"), a.netloc, os.path.basename(i.path)])
        if os.path.splitext(i.path)[1] == "":
            filename = filename + ".png"

        path = os.path.expanduser(d + "/" + filename)
        open(path, 'wb').write(r.content)
        image = "\n![](%s)" % path
    except requests.exceptions.RequestException:
        image = " Unable to fetch image: " + u
    except:
        image = " Unable to save image (check that name and path is correct): " + path

descr = ""
if (p.description):
    descr = " " + p.description

a = "<%s>" % url
if (p.title):
    a = "[%s](%s)" % (p.title, url)


print(a + descr + image)

