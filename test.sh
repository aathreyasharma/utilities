#!/bin/bash

# echo "Enter you name.."
# read name
# echo "Hello, $name"

NAME[0]="Zara"
NAME[1]="Qadir"
NAME[2]="Mahnaz"
NAME[3]="Ayan"
NAME[4]="Daisy"

echo 'Printing Array'
echo "----------------------"
echo "First Index : ${NAME[0]}"
echo "Second Index : ${NAME[1]}"

echo "First Method: ${NAME[*]}"
echo "Second Method: ${NAME[@]}"
echo ""


echo "Mathematical expressions"
echo "----------------------"
echo `expr 10 + 10`
echo
echo 'Conditional statements'
echo "----------------------"
echo "Enter first number"
#read a
echo "Enter Second Number"
#read b
a = 10
b = 10
if [ $a == $b ]
then
	res="Equal"
else
	res="Not Equal"
fi
echo "$a is $res to $b"

echo ""
echo "System Command"
echo "-----------------------"
speedtest
if [ $? == 0 ]
then
	echo 'success'
else
	echo 'failed'
fi

