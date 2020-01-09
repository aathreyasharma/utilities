#!/bin/bash
# ===
# use next line to run this script
# while i=1; do sleep 3;/home/u7/cp.sh; done
# OR
# use heartbeat script chb.sh which does the same
# make appropriate adjustments for directory and username information
# ===

dt=`date '+%d_%m_%Y_%H_%M_%S'`
#echo "$dt"
fn="$HOME/digitoryapi/log/$dt.txt"
#c=`ps ax | grep "puma" | grep "3000" | grep -v grep| wc -l`
c=`ps ax | grep "puma" | grep -v grep| wc -l`
#curl http://142.93.163.17
#resp=$?
#if test "resp" != 0; then
#	echo "curl has failed - server is down"
#else
#	echo "curl is working - server is up"item['actual']
#fi

if [ $c -ne 0 ]; then
  echo "$dt | Process is running."
	pid=`ps -ef | grep -v vi | grep -v grep | grep "puma" |awk '{print $2}'`
	st=`ps -eo pid,lstart | grep -v grep | grep $pid`
	echo "$dt | process rails is running : => pid & started @ $st"
else
  echo "$dt | Process is not running."
	cd;cd $HOME/digitoryapi
	echo "$dt | `pwd`"
	echo "$fn"
	rails s --binding=0.0.0.0 > $fn 2> $fn &
	sleep 10
  echo "==================script started the rails again==============="
fi

fileName="$HOME/automation/log/job_$dt.txt"
count=`ps ax | grep "jobs" | grep -v grep | wc -l`
if [ $count -ne 0 ];then
        echo "$dt | Process is running."
                pid=`ps -ef | grep -v vi | grep -v grep | grep "jobs" | awk '{print $2}'`
                st=`ps -eo pid,lstart | grep -v grep | grep $pid`
                echo "$dt | Process Jobs is running : => pid & started @ $st"
else
        echo "$dt | Process is not running."
        cd;cd $HOME/automation/scripts
        echo "$dt | `pwd`"
        echo "$fileName"
        python3 -u jobs.py > $fileName 2> $fileName &
        sleep 10
  echo "==================script started JOBS again==============="
fi

