#!/bin/bash

Connection_URL = "http://127.0.0.1:8000"


while true ; do 
  echo "select option :"
  echo " 1 => to add a car"
  echo " 2 => to delete item "
  echo " 3 => to log out from this script"
  read -p "you choice is : " choice

  case $choice in
    1)
      echo "you will add a car "
      read -p "ID : " id
      read -p "car name : " name
      read -p "country : " country
      read -p "brand : " brand
      read -p "model : " model 
      read -p "year_of_model : " year_of_model
    
      curl -s -X POST "$Connection_URL/cars/$id" \ -H "Content-Type : application/json" \ -d "{\"id\":$id , \"name\":\"$name\" , \"country\":\"$country\",\"brand\":\"$brand\" , \"model\":\"$model\" , \"year_of_model\":\"$year_of_model\"}"

      echo "adding is successfully done "
      ;;


     2)
       echo "Enter the ID of item" 
       read -p "ID : " id

       curl -s -X DELETE "$BASE_URL/cars/$id"
       echo "deleting successfully done "
       ;;

     3)
       echo "Exit the system"
       break
       ;;

     *)
        echo "you choice isn't exist, please enter right option"
	;;

   esac
done
