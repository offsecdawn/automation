#!/bin/bash

if [[ -z $1 ]];
then
	echo "Please provide the JS file name!"
	echo "./2script.sh JS_file_name JSON_file_name"
	exit
fi

if [[ -z $2 ]];
then
        echo "Please provide the JSON file name!"
	echo "./2script.sh JS_file_name JSON_file_name"
        exit
fi

source ~/.bash_profile
rm -f grep_output.txt
echo "All of output is going to be saved in [grep_output.txt] file"
echo "************************************************************"

for i in $(cat $1)
do
	response_code=`curl -k -i --silent  $i --parallel-max 50 --connect-timeout 3 | tac| tac | head -n 1 | cut -d' ' -f2 `
        echo $i $response_code
        if [[ $response_code = 200 ]];
        then
		echo "========================================================================================================================================" >> grep_output.txt
                echo $i >> grep_output.txt
 		curl -k -s $i |tac |tac | js-beautify | grep --color=always -i -E -- 'token|swagger|admin|jenkin|sandbox|wordpress|drupal|csrf|vpn|aws|key|api' >> grep_output.txt
		echo "========================================================================================================================================" >> grep_output.txt
        fi
done

for i in $(cat $2)
do
        response_code=`curl -k -i --silent  $i --parallel-max 50 --connect-timeout 3 | tac| tac | head -n 1 | cut -d' ' -f2 `
        #echo $i $response_code
        if [[ $response_code = 200 ]];
        then
                echo "========================================================================================================================================" >> grep_output.txt
                echo $i >> grep_output.txt
                curl -k -s $i |tac |tac | grep --color=always -i -E -- 'token|swagger|admin|jenkin|sandbox|wordpress|drupal|csrf|vpn|aws|key|api' >> grep_output.txt
                echo "========================================================================================================================================" >> grep_output.txt
        fi
done

