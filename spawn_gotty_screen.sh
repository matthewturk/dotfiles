echo -n "Which screen terminal to cast? "
read term
screen -t 'shared' /home/mturk/Development/go/bin/gotty -r screen -x IRC -p ${term}
