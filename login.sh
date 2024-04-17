#!/bin/bash
#take username, text password then generates the hash password and login



#getting Salt
function getSalt { 

	local USER="${1}"
	local DB_USER="${2}"
	local DB_PASS="${3}"
	local RESULT
	RESULT=$(mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "SELECT SALT FROM ACCOUNTS WHERE USERNAME = '${USER}'")
	if [ -z "${RESULT}" ]
		then
			echo "empty"
		else
			echo "${RESULT}"
		fi

}

#logging and returning the logged user
function login {
	local DB_USER="${1}"
	local DB_PASSWORD="${2}"
	local USERNAME
	local TEXT_PASS
	local PASSWORD
	local SALT
	local AUTH

	echo "Enter your username: ">&2
	read USERNAME
	echo "Enter your password">&2
	read -s TEXT_PASS
	
	SALT=$(getSalt "${USERNAME}" "${DB_USER}" "${DB_PASSWORD}")
	while [ "${SALT}" == "empty" ]
		do
			echo "USER NOT FOUND TRY AGAIN">&2
			echo "Enter username:">&2
			read USERNAME
			echo "Enter password">&2
			read -s TEXT_PASS
			SALT=$(getSalt "${USERNAME}" "${DB_USER}" "${DB_PASSWORD}")
		done
	PASSWORD=$(openssl passwd -6 -salt "${SALT}" "${TEXT_PASS}")
	AUTH=$(checkPassword "${PASSWORD}" "${DB_USER}" "${DB_PASSWORD}" "${USERNAME}")
	while [ "${AUTH}" != "auth" ]
		do
			echo "INCORRECT PASSWORD TRY AGAIN">&2
			read TEXT_PASS
			PASSWORD=$(openssl passwd -6 -salt "$SALT" "${TEXT_PASS}")
			AUTH=$(checkPassword "${PASSWORD}" "${DB_USER}" "${DB_PASSWORD}" "${USERNAME}")	
		done
		echo "$(authenticated)">&2
		echo "${USERNAME}"
}
