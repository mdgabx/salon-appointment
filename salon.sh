#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {

  echo -e "\nWelcome to My Salon, how can I help you\n"

  # get the services

  SERVICES=$($PSQL "SELECT * FROM services")

  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo -e "$SERVICE_ID) $SERVICE_NAME"
  done

  # pick a service_id

  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-5]$ ]]
  then 
      MAIN_MENU
  else 
      
      # ask for phone number
      echo -e "\nEnter your phone number"

      read CUSTOMER_PHONE

      # check if phone number exist

      CHECK_PHONE_EXIST=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

     if [[ -z $CHECK_PHONE_EXIST ]]
     then
        echo "phone doesn't exist"
      else 
        echo "phone exist"
     fi

     # read CUSTOMER_NAME

     # read SERVICE_TIME
  fi


}

MAIN_MENU
