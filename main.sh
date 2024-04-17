#!/bin/bash
echo "####################THIS SCRIPT IS AMAZING####################"
echo "Please Enter database user: "
read DB_USER
echo "Please Enter db password"
read -s DB_PASSWORD

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" < ./create_db_tables.sql

. ./signup.sh
. ./login.sh
. ./checkers.sh
. ./display.sh
. ./operations.sh
echo "please choose login or signup"
echo "[1] signup"
echo "[2] login"
read LOGIN_SIGNUP

while [ $( echo $LOGIN_SIGNUP | grep -c "^[1-9]*$" ) -eq 0 ] || [ $LOGIN_SIGNUP -gt 2 ]
	do
		echo "Please enter valid number"
		read LOGIN_SIGNUP
	done

if [ $LOGIN_SIGNUP -eq 1 ]
	then
		LOGGED_USER=$(signup "${DB_USER}" "${DB_PASSWORD}")
	else
		LOGGED_USER=$(login "${DB_USER}" "${DB_PASSWORD}")
	fi
	
LOGGED_USER_ID=$( mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -D "BASHPROJECT" -s -N -e "select ID from ACCOUNTS where USERNAME='${LOGGED_USER}'")
chooseGreeting "${LOGGED_USER}"
INSERTION=$(options)

while [ $INSERTION -ne 4 ]
	do
		[ $INSERTION -eq 1 ] && showMeal ${LOGGED_USER_ID} "${DB_USER}" "${DB_PASSWORD}"
		[ $INSERTION -eq 2 ] && addMeal ${LOGGED_USER_ID} "${DB_USER}" "${DB_PASSWORD}"
		[ $INSERTION -eq 3 ] && removeMeal ${LOGGED_USER_ID} "${DB_USER}" "${DB_PASSWORD}"
		[ $INSERTION -eq 4 ] && exit 0
		INSERTION=$(options)
	done


