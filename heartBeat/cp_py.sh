
dt=`date '+%d_%m_%Y_%H_%M_%S'`
processName=""
scriptName=""
fileName="$HOME/workspace/log/job_$dt.txt"
count=`ps ax | grep $processName | grep -v grep | wc -l`
if [ $count -ne 0 ];then
    echo "$dt | Process is running."
    pid=`ps -ef | grep -v vi | grep -v grep | grep $processName | awk '{print $2}'`
    st=`ps -eo pid,lstart | grep -v grep | grep $pid`
    echo "$dt | Process Jobs is running : => pid & started @ $st"
else
    echo "$dt | Process is not running."
    cd;cd $HOME/workspace/scripts
    echo "$dt | `pwd`"
    echo "$fileName"
    python3 -u $scriptName > $fileName 2> $fileName &
    sleep 10
    echo "==================script started JOBS again==============="
fi
