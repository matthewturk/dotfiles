#!/bin/zsh

type="$(echo -e 'pr\nissue' | rofi -dmenu)"

repos="yt-project/yt
yt-project/yt_idv
yt-project/widgyts"

repo="$(echo -e $repos | rofi -dmenu)"
[ -z "$repo" ] && exit 0;

id="$(gh -R$repo $type list -L100 | rofi -dmenu | cut -f1)"
[ -z "$id" ] && exit 0;

gh -R"$repo" $type view -w "$id"
