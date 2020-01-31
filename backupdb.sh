#!/bin/bash
# Pass 
dbName=$1
collName=$2
format='.json'
echo "Taking a backup of the database: $dbName and collection: $collName"
dt=`date '+%Y.%m.%d_%H:%M:%S'`
fileLoc="$HOME/.mongobackup/"
if [ ! -d $fileLoc ]; then
	mkdir $fileLoc
fi
expFile=$collName-$dt$format
mongoexport -d $dbName -c $collName -o $fileLoc$expFile
