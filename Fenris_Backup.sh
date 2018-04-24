#! /bin/bash
echo "This will use rsync to backup to Fenris"
echo "Press enter to continue..."
read
echo "Which folder would you like to backup?"
echo "1. Local Users folder
2. TDM Users folder"
#read input

while read input
do
    if ["$input" == "1" || "2" || "3"]
        if ["$input" == "1"]
            then
            cd /Users
        elif ["$input" == "2"]
            echo "This is where we would cd to TDM volume"
        else
        
