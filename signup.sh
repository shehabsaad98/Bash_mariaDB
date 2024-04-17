#!/bin/bash
#takes customer name, email and password and stores it in accounts table in database


function signup {
	local DB_USER="${1}"
	local DB_PASSWORD="${2}"
        local CUSTOMER
        local EMAIL
	local TEXT_PASS
        local PASS
	local SALT
	local SQLFILE
#take the Email from user
	echo "Enter your E-mail">&2
	read EMAIL
	while [ $(isEmail ${EMAIL}) == "invalid" ]
		do
			echo "Please enter a valid email">&2
			read EMAIL
		done
#take username from user
	echo "Enter your username">&2
	read CUSTOMER
#take plain text password from user and generate its hash to store in database
	echo "Enter your password">&2
	read -s TEXT_PASS
	SALT=$(openssl passwd -6 "$TEXT_PASS" | cut -d"$" -f3)
	PASS=$(openssl passwd -6 -salt "$SALT" "$TEXT_PASS")

	SQLFILE=$(cat /root/project/create_users.sql | sed "s|NEW_CUSTOMER|${CUSTOMER}|g; s|NEW_EMAIL|${EMAIL}|g; s|NEW_PASS|${PASS}|g; s|NEW_SALT|${SALT}|g")

	echo "${SQLFILE}" | mysql -u "${DB_USER}" -p"${DB_PASSWORD}"
	echo "${CUSTOMER}"
	
}
