#!/bin/zsh

if [ $# -eq 0 ]
then
    echo "Please supply a list of repositories."
    exit 0;
fi

type="$(echo -e 'pr\nissue\nnew issue\nnew issue web' | rofi -dmenu -p 'Explore' )"
[ -z "$type" ] && exit 0;

repo="$(rofi -dmenu -p 'Repository' -i -input $1)"
[ -z "$repo" ] && exit 0;

if [ "$type" = "new issue web" ]
then
    google-chrome https://github.com/${repo}/issues/new
elif [ "$type" = "new issue" ]
then
    title=$(echo "" | rofi -dmenu -p "Issue Title")
    body=$(echo "" | rofi -dmenu -p "Body of issue")
    gh -R"$repo" issue create -b "${body}" -t "${title}" -w
else
    id="$(gh -R$repo $type list -L100 | rofi -dmenu | cut -f1)"
    [ -z "$id" ] && exit 0;
    
    gh -R"$repo" $type view -w "$id"
fi
