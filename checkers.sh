#/bin/bash


##checks email and returns 'invalid' or 'valid'
function isEmail {
        local EMAIL="${1}"
        local CHECK_EMAIL=0
        CHECK_EMAIL=$(echo "$EMAIL" | grep -c "^[a-zA-Z1-9_]*@[a-zA-Z1-9_]*\.[a-zA-Z1-9_]*$")
        if [ $CHECK_EMAIL -eq 0 ]
                then
                        echo "invalid"
                else
                        echo "valid"
                fi
}

#authenticates the provided username and password
function checkPassword {
        local CHECK_PASSWORD="${1}"
        local DB_USER="${2}"
        local DB_PASS="${3}"
        local USER="${4}"
        local RESULT

        RESULT=$(mysql -u "${DB_USER}" -p"${DB_PASS}" -D "BASHPROJECT" -s -N -e "SELECT PASSWORD FROM ACCOUNTS WHERE USERNAME='${USER}'")
        if [ "${RESULT}" == "${CHECK_PASSWORD}" ] && [ -n "${RESULT}" ]
                then
                        echo "auth"
                else
                        echo "notauth"
                fi
}
