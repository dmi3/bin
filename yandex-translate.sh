#!/bin/bash

#  Decription
#  ----------
#  CLI Yandex Translate API ru↔en. Automatically detects language. Translates any language to Russian, and Russian to English.

#  Author: Dmitry (http://dmi3.net)
#  Source: https://github.com/dmi3/bin

#  Usage
#  -----
#  `yandex-translate.sh cat is a small, typically furry, carnivorous mammal` # en → ru
#  `yandex-translate.sh die Hauskatze ist eine Unterart der Wildkatze` # de → ru
#  `yandex-translate.sh кот это маленькое, хищное и очень хитрое млекопитающее` # ru → en

key=$(cat ~/gitstuff/keys/yandex_translate) # get your key https://tech.yandex.ru/keys/get/?service=trnsl&ncrnd=1455

if [[ $* =~ ^.*[А-Яа-яЁё]+.*$ ]] ; then lang=en; else lang=ru; fi # if at least one Cyrillic symbol
curl -s "https://translate.yandex.net/api/v1.5/tr.json/translate?key=$key&lang=$lang&" --data-urlencode "text=$*" | awk -F'"' {' print $10 '}