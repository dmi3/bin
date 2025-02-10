#!/usr/bin/python3

#  Decription
#  -----------
#  Wrapper around [webpreview](https://pypi.org/project/webpreview/). Takes url, downloads a preview image
#  (or image iself, if url points to image) and returns formatted markdown with page title and description.
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
#
#      If you have OpenGraph.io api key, add it as last argument to try it if webpreview finds nothing useful
#      $ url-preview-md.py ~/img http://developer.run/70 e2b0e47c-8a03-11ef-b1b2-13950b80fc62


import os
import sys
import requests
from urllib.parse import urlparse, urljoin, quote_plus
from datetime import datetime
from webpreview import webpreview
from webpreview.models import WebPreview

d = os.path.expanduser(sys.argv[1])
os.makedirs(d, exist_ok = True)

url = sys.argv[2]
opengraph_api_key = sys.argv[3] if len(sys.argv) > 3 else None

headers = {"Accept": "*/*", "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36"}
exclusions = ["amazon.", "x.com", "twitter.com", "youtube.com"]

p = WebPreview(url, None, None, None)

try:
    if all(x not in url for x in exclusions):
        p = webpreview(url, headers=headers)
except:
    print("Unable to fetch url:" + url)
    exit()

# If link is image - use it
if p.title == None and p.description == None and p.image == None:
    h = requests.head(url, allow_redirects=True, headers = headers)

    content_type = h.headers.get('content-type')
    if content_type != None and content_type.startswith('image/'):
        p.image = url

try:
    if opengraph_api_key != None and p.image == None:
        # https://www.linkpreview.net might be an alternative
        response = requests.get('https://opengraph.io/api/1.1/site/%s?app_id=%s' % (quote_plus(url), opengraph_api_key))
        data = response.json()

        img = data['hybridGraph'].get('image')
        if img == None:
            img = data['hybridGraph'].get('imageSecureUrl')

        p = WebPreview(url, data['hybridGraph'].get('title'), data['hybridGraph'].get('description')[:400], img)
except:
    print("Unable to fetch url:" + url)
    exit()

image = ""
if (p.image):
    try:
        u = p.image
        if not u.startswith("http"):
            u = urljoin(url, p.image)
        r = requests.get(u, allow_redirects=True, headers = headers)
        a = urlparse(url)
        i = urlparse(u)
        filename = "_".join([datetime.now().strftime("%Y_%m_%d"), a.netloc, os.path.basename(i.path)])
        filename, ext = os.path.splitext(filename.lstrip("/"))
        if ext == "":
            ext = ".png"

        path = os.path.join(d, filename + ext)
        pcnt = 1

        while os.path.exists(path):
            path = os.path.join(d, "%s_%s%s" % (filename, pcnt, ext))
            pcnt += 1

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

