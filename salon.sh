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

      CHECK_PHONE_EXIST=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")

     if [[ -z $CHECK_PHONE_EXIST ]]
     then

        # Enter name if phone doesn't exist
        echo -e "\nEnter your name"

        read CUSTOMER_NAME

        echo -e "\nEnter appointment time"

        read SERVICE_TIME

        INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")

        GET_CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

        INSERT_RESULT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($GET_CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

        echo $INSERT_RESULT_APPOINTMENT

      else 
        echo "phone exist"
     fi



  fi


}

MAIN_MENU
