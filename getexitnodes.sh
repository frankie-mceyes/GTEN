#!/bin/bash
## Made with love by Frankie McEyes
## https://github.com/frankie-mceyes

if [ ! curl -V >> /dev/null 2>&1 ]
then
	echo "You need CURL to use this script.\nYou can install it using 'sudo apt install curl'"
	exit
elif [[ "$1" == '-' ]]
then
	echo -e "Usage:\n\t ./getexitnodes.sh [filename]"
	exit
elif [ -z "$1" ]
then
	file="./tornodes.txt"
	echo "[!] Filename not specified. All nodes will be written on tornodes.txt"
else
	file="$1"
	echo "[+] All nodes will be written on $file"
fi

raw="$(curl -s "https://check.torproject.org/exit-addresses" "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1")"

if [ -f $file ]
then
	initcount=$(wc -l $file | awk '{print $1}')
else
	initcount=0
fi

nodes="$(echo $raw | grep -E -o "[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}" | grep -xv 1.1.1.1 | sort -u)"
amount=$(echo $nodes | sed 's/\s/\n/g' | wc -l)

echo "[i] Writing $amount exit nodes on $file..."
echo "$nodes" >> $file
count=$(wc -l $file | awk '{print $1}')
subtraction=$(($count-$initcount))

echo -e "[+] Nodes written: $subtraction\n[i] Total entries: $count"
	
echo -e "\n[i] Removing duplicates entries..."
initcount=$(wc -l $file | awk '{print $1}')
cat $file | sort -u > /tmp/$file
mv /tmp/$file .
newcount=$(wc -l $file | awk '{print $1}')
subtraction=$(($initcount-$newcount))

if [[ $subtraction != 0 ]]
then
	echo "[+] $subtraction duplicate addresses have been removed."
	echo "[+] Total entries: $newcount"
else
	echo "[-] There are no duplicate entries."
fi
