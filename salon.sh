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

}

MAIN_MENU
