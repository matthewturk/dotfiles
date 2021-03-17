#!/bin/zsh

if [ $# -eq 0 ]
then
    echo "Please supply a list of repositories."
    exit 0;
fi

type="$(echo -e 'pr\nissue\nnew issue' | rofi -dmenu -p 'Explore' )"
[ -z "$type" ] && exit 0;

repo="$(rofi -dmenu -p 'Repository' -i -input $1)"
[ -z "$repo" ] && exit 0;

if [ "$type" = "new issue" ]
then
    gh -R$repo issue create -w
else
    id="$(gh -R$repo $type list -L100 | rofi -dmenu | cut -f1)"
    [ -z "$id" ] && exit 0;
    
    gh -R"$repo" $type view -w "$id"
fi
