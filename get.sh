#!/bin/bash

collName=$1
sName=$2
format='.json'
uName='deploy'
dir='dbbackup/'
fileLoc="$HOME/$dir"
if [ ! -d $fileLoc ]; then
        mkdir $fileLoc
fi
server=rms-$sName.digitory.com
ssh $uName@$server ./backupdb.sh $collName
fName=`ssh $uName@$server ls -rt $dir | grep $collName | tail -1`
echo Copying: $fName
scp $uName@$server:/home/$uName/$dir/$fName $HOME$fileLoc
