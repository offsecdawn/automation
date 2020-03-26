#!/bin/bash

if [[ -z $1 ]];
then
	echo "please provide the domain name"
	exit
fi
for i in $(cat dorklist.txt)
do
	echo $i
	echo "https://github.com/search?q=%22$1%22+$i&type=Code"
	echo ""
	echo ""
done

