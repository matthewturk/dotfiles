echo -n "Which screen terminal to cast? "
read term
ip_address=`hostname -I|cut -f1 -d\ `
screen -t 'shared' /home/mturk/Development/go/bin/gotty -a ${ip_address} -r screen -x IRC -p ${term}
