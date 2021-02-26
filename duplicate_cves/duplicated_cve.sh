#!/bin/bash

old_file="${PWD}/old"
new_file="${PWD}/new"

added_cves="${PWD}/added"
removed_cves="${PWD}/removed"
common_cves="${PWD}/common"

if [ -f "$added_cves" ]; then
	rm $added_cves
fi

if [ -f "$removed_cves" ]; then
	rm $removed_cves
fi

if [ -f "$common_cves" ]; then
	rm $common_cves
fi

while IFS= read -r line; do

	if [ $line ]; then
		if cat $old_file | grep -q "$line"; then
			echo "$line" >> $common_cves
		else
			echo "$line" >> $added_cves
		fi
	fi

done < $new_file

echo "*****************" >> $common_cves

while IFS= read -r line; do

	if [ $line ]; then
		if cat $new_file | grep -q "$line"; then
			echo "$line" >> $common_cves
		else
			echo "$line" >> $removed_cves
		fi
	fi

done < $old_file


echo "\n===================common cves====================="

if [ -f "$common_cves" ]; then
	cat $common_cves
else
	echo "Not CVEs"
fi

echo "\n===================added cves====================="

if [ -f "$added_cves" ]; then
	cat $added_cves
else
	echo "Not CVEs"
fi

echo "\n===================removed cves====================="

if [ -f "$removed_cves" ]; then
	cat $removed_cves
else
	echo "Not CVEs"
fi

