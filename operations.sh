#!/bin/bash

function addMeal {
	local LOGGED_USER_ID=${1}
	local DB_USER="${2}"
	local DB_PASS="${3}"
	local INSERTION
	local CHOOSEN_MEAL
	menue
	read INSERTION
	while [ $(echo $INSERTION | grep -c "^[1-5]$") -eq 0 ]
		do
			echo "Enter a valid option">&2
			read INSERTION
		done
	 [ $INSERTION -eq 1 ] && CHOOSEN_MEAL="PIZZA"
	 [ $INSERTION -eq 2 ] && CHOOSEN_MEAL="BURGER"
	 [ $INSERTION -eq 3 ] && CHOOSEN_MEAL="PIE"
	 [ $INSERTION -eq 4 ] && CHOOSEN_MEAL="SALAD"
	 [ $INSERTION -eq 5 ] && CHOOSEN_MEAL="SAUSAGE"
	 mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -e "INSERT INTO MEALS (NAME,CUSTOMER_ID) VALUES ('${CHOOSEN_MEAL}', ${LOGGED_USER_ID})"
	 echo "******************** MEAL ADDED ********************">&2
	 echo ' '
}

function showMeal {
	local LOGGED_USER_ID=${1}
        local DB_USER="${2}"
        local DB_PASS="${3}"
	local MEALS

	MEALS=($( mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "SELECT NAME FROM MEALS WHERE CUSTOMER_ID=${LOGGED_USER_ID}"))
	if [ ${#MEALS[@]} -ne 0 ]
		then 
			echo "|---------------------------------------------|">&2
			echo "|"
			for meal in "${MEALS[@]}";
				do
					echo "|-----------${meal}">&2
					echo "|">&2
				done
			echo "|---------------------------------------------|">&2
		else
			echo "YOU DON'T HAVE MEALS ADDED YET !"
		fi
}

function removeMeal {
	local LOGGED_USER_ID=${1}
        local DB_USER="${2}"
        local DB_PASS="${3}"
	local REMOVE_ID	
	MEALS_NAME=($( mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "SELECT NAME FROM MEALS WHERE CUSTOMER_ID=${LOGGED_USER_ID}"))
	MEALS_ID=($( mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "SELECT ID FROM MEALS WHERE CUSTOMER_ID=${LOGGED_USER_ID}"))
        if [ ${#MEALS_NAME[@]} -ne 0 ]
                then
			echo "CHOOSE THE MEAL YOU WOULD LIKE TO REMOVE"
			echo " "
                        echo "|---------------------------------------------|">&2
                        echo "|"
			for ((id_name=0; id_name<${#MEALS_NAME[@]}; id_name++));
                                do
                                        echo "|----------[${MEALS_ID[id_name]}] ${MEALS_NAME[id_name]}">&2
                                        echo "|">&2
                                done
                        echo "|---------------------------------------------|">&2
			echo " "
			read REMOVE_ID
			mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "DELETE FROM MEALS WHERE CUSTOMER_ID=${LOGGED_USER_ID} AND ID=${REMOVE_ID}"
			echo "*************** MEAL HAS BEEN DELETED ***************"
                else
                        echo "YOU DON'T HAVE MEALS ADDED YET !">&2
                fi

}
