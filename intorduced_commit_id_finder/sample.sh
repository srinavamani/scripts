#!/bin/bash

echo "Kernel - commit introduced version finder using commit ID"

current_dir=${PWD}
commits_list="$current_dir/commit_list.txt"

cd ${HOME}/linux-stable/

while [ 1 ]
do

read -p "Enter commit ID - " main_commit_id

if [ $main_commit_id ]
then

main_commit_message=`git log --format=%B -n 1 $main_commit_id | head -1`
echo $main_commit_message

git log --all --grep="$main_commit_message" --pretty=oneline > $commits_list

while IFS= read -r line; do

	if [ "$line" ]
	then
		echo "$line"
		commit_id=`echo $line | awk '{print $1}'`
		git describe --contains $commit_id | awk -F~ '{print $1}'
	else
		echo ""
	fi

done < $commits_list


echo "========================================================================================================"

else

echo "Thank You..."
exit

fi


done

cd $current_dir
