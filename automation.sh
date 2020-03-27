#!/bin/bash
echo ""
echo "***********************************************************************************************************************"
echo "This script has been developed to automate recon process such as "
echo "	1.HTTProbing"
echo "	2.AQUATONE screenshot"
echo "	3.WAYBACKURL processing"
echo "	4.GITHUB recon link generation"
echo "	5.S3bucket enumeration"
echo "	6.PORT enumeration"
echo "***********************************************************************************************************************"

source ~/.bash_profile
echo -e "\nPlease provide root scope file for enumeration:"
read root_domain_file
echo -e  "\nPlease provide the unique subdomain file name:"
read subdomain_file
echo -e "\nPlease provide the root_domain_name name for GitHub recon:"
read domain_name



#echo $subdomain_file
rm -f httprobe_file.txt




echo -e "\n*************************HTTP probing has been initiated***********************************************"
#echo "Plese provide the httprobe file name in order to take screenshot of the tool"
cat $subdomain_file | httprobe >> httprobe_file.txt
echo "[httprobe_file.txt] file has been created"
echo ""
echo "***********************************************************************************************************************"
echo ""



echo -e "\n*************************Aquatone screenshot has been initiated***********************************************"
cat httprobe_file.txt | aquatone 
echo ""
echo "Aquatone screenshot is done successfully. Please check the screenshot"
echo "***********************************************************************************************************************"
echo ""

echo ""
echo -e "\n*************************GitHub link extract has been initiated***********************************************"
echo ""
bash 1githubsearchurl.sh $domain_name
echo ""
echo "*******************************************************************************************************************"



echo ""
echo -e "\n*************************S3 bucket identification process has been initiated***********************************************"
echo  ""
for i in $(cat $subdomain_file)
do
	#ruby /home/offsecdawn/tools/teh_s3_bucketeers/lazys3/lazys3.rb $i
	python3 /home/offsecdawn/tools/teh_s3_bucketeers/S3Scanner/s3scanner.py $i
done
echo ""
echo "*******************************************************************************************************************"


echo -e "\n*************************Javascript link extract has been initiated***********************************************"
bash 1script.sh $root_domain_file
bash 2script.sh wayback_js_files.txt wayback_json_files.txt
echo ""
echo "Javascript link extract is complete now"
echo -e "\n******************************************************************************************************************"



#echo -e "\n*************************Port enumeration extract has been initiated***********************************************"
#echo ""
#rm -f portscan.txt
#nmap -n -Pn -sV -v -T4 -p- -iL $subdomain_file	-oN namp.scan.txt
#for i in $(cat $subdomain_file)
#do 
#	sudo masscan -p1-65535 $(dig +short $i | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -1) --max-rate=1000 |& tee $strip_scan
#done
#echo ""
##echo "Port scanning is done."
#echo "************************************************************************************************************************"
#echo ""


echo ""
echo "**************************************TO DO LIST*************************************************************"
echo "	1.Need to perform Github enumeration manually using the links generated out of the script"
echo "	2.Need to perform s3 bucket enumeration deeply"
echo "  3.Perform port scan explicitly"
echo "************************************************************************************************************************"
echo ""
echo ""

echo "To download the file, please check out this link in your browser: http://167.71.238.253:8000"


python -m SimpleHTTPServer 8000



