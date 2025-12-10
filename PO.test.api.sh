#!/bin/bash
###VARIABLES###

API_URL="http://127.0.0.1:8000/cars/"
CONCURRENT=1000
FILE="$HOME/Project_API/data.txt"
################################

for i in $(seq 1 $CONCURRENT)
do	
	echo $i
	curl -X POST \
    -H "Content-Type: application/json" \
    -d @$FILE \
    -s -o /dev/null \
	-k -L -i "$API_URL"
      sleep 2	
done

