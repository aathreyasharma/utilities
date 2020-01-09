#!/bin/bash

sName=$2
collName=$1
format='.json'
echo $sName
echo $collName
dt=`date '+%Y.%m.%d_%H:%M:%S'`
fileLoc="$HOME/dbbackup/"
if [ ! -d $fileLoc ]; then
	mkdir $fileLoc
fi
#uName='deploy'
#server=`rms-$sName@digitory.com`
#ssh $uName@$server `expdb $collName`
#fName=`ssh $uName@$server 'ls -rt dbbackup/ | tail -1'`
#echo Copying: $fName
#scp $uName@$prodServer:/home/deploy/dbbackup/$fName $fileLoc
expFile=$collName-$dt$format
#echo $expFile
#echo $fileLoc$expFile
mongoexport -d digitory -c $collName -o $fileLoc$expFile
