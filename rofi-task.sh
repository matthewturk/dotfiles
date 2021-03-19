#!/usr/bin/env sh

ID=$(task export status:pending | jq -r '"Create new task",(sort_by( -.urgency )[] | [ (.id|tostring), .description ] | join("	"))' |
  rofi -no-auto-select -i -dmenu -p "Task" |
  cut -f 1)
[ -z "$ID" ] && echo "Cancelled." && exit

if [ "$ID" = "Create new task" ]
then
    task_cmd=$(echo "" | rofi -dmenu -theme-str 'listview { enabled: false;}' -p "Task Specification")
    task add ${task_cmd}
    exit 0;
fi

ACTION=$(printf "done\nedit\nstart\nstop" | rofi -no-auto-select -i -dmenu -p "Action")
[ -z "$ACTION" ] && echo "Cancelled." && exit

gnome-terminal --title taskwin --hide-menubar -- /usr/bin/task "${ID}" "${ACTION}"
