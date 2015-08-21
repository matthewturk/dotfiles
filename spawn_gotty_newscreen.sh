session_name=`date -Is`
screen -t 'shared-full' /home/mturk/Development/go/bin/gotty -r screen -S gotty-${session_name}
