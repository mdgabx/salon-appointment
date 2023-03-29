#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~ MY SALON ~~~~\n"

MAIN_MENU() {

  echo -e "\nWelcome to My Salon, how can I help you?\n"

  SERVICES_MENU=$($PSQL "SELECT * FROM services")

  echo "$SERVICES_MENU" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done  

  echo -e "\nChoose service to be scheduled"

  read SERVICE_ID_SELECTED

  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-5]$ ]]
  then
    MAIN_MENU
  else 

    echo -e "\nEnter your phone number"
    read CUSTOMER_PHONE

    echo -e "\nEnter your name"
    read CUSTOMER_NAME

    echo -e "\nEnter time to be scheduled"
    read SERVICE_TIME

  fi

}

MAIN_MENU
