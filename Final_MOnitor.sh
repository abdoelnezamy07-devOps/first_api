#!/bin/bash

##VARIABLES AND FUNCTIONS
function get_server_metrics() {
    SERVER_IP=$(hostname -I | awk '{print $1}')
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d'.' -f1)%
    RAM_AVAILABLE=$(free -m | awk 'NR==2{print $4 "MB"}')
    DISK_SPACE=$(df -h / | awk 'NR==2 {print $4}')

    cat <<EOF
---------------------------------------------
    "ip": "$SERVER_IP",
    "cpu_usage": "$CPU_USAGE",
    "ram_available": "$RAM_AVAILABLE",
    "disk_space": "$DISK_SPACE"
EOF
}

function Sending() {
   echo "Status code is $STATUS_CODE " 
   echo "IP is $IP_SERVER " 
   echo "Date of request $DATE_OF_REQUEST " 
   echo "Request time $REQUEST_TIME" 
   echo "The request is $REQUEST " 
}

LOG_FILE="/home/abdelrhman/Project_API/AP.log"
STATUS_CODE=$(tail -n1 "$LOG_FILE" | cut -d " " -f9)
REQUEST=$(tail -n1 $LOG_FILE | cut -d " " -f6)
DATE_OF_REQUEST=$(tail -n1 $LOG_FILE | cut -d " " -f1)
#SERVER_METRICS=$(get_server_metrics)
#ALERT_API=______________________________________________________________
######################################################

### Commands ##############

tail -n 0 -f "$LOG_FILE" | while read -r NEW_LINE; do
##############################################################################
#VARIABLES i wrote it inside the loop to get the get the typical time and date
##############################################################################  

REQUEST_TIME=$(tail -n1 $LOG_FILE | cut -d " " -f2)
IP_SERVER=$(tail -n1 $LOG_FILE | cut -d " " -f4 | cut -d ":" -f1)

JSON_PAYLOAD=$(cat <<EOF
{
  "error": "$STATUS_CODE Error",
  "timestamp": "$DATE_OF_REQUEST:$REQUEST_TIME",
  "server_metrics": {
    $SERVER_METRICS
  }
}
EOF
)

	if [[ "$STATUS_CODE" =~ ^[0-9] ]];
	then
		get_server_metrics
		Sending
		case $STATUS_CODE in
	       		2??)
				echo -e "The process\033[32m[DONE]\033[0m correctly"
				echo
			
				;;
			3??)
				echo -e "there is a \033[33m[REDIRECT]\033[0m Error"
				echo

				;;
			4??)
				echo -e "Not found \033[31m[ERROR]\033[0m"
				echo

				;;
			5??)
				echo -e "Server \033[31m[ERROR]\033[0m"
				echo
				#function get_server_metrics
				#curl -s -X POST -H "Content-Type: application/json" -d "$JSON_PAYLOAD" $ALERT_API
				
				;;


		esac
	fi
done


