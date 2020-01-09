#!/bin/bash

dt=`date '+%Y%m%d-%H%M%S'`
dt2=`date '+%Y-%b-%d %H:%M:%S'`
backupDir=$HOME/.dailymongobackup
if [ ! -d $backupDir ];then
	mkdir $HOME/.dailymongobackup
fi
cd $HOME/.dailymongobackup
mongodump -d digitory && tar -czf dump$dt.tar.gz dump/ && rm -rf dump/
echo "Mongo Backup taken at: $dt2"

