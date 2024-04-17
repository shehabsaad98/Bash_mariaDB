#!/bin/bash
#scripts just for visual display

function chooseGreeting {
	echo ' '
	echo "                 WELCOME "${1}" "
	echo ' '
}

function authenticated {
	echo ' '
	echo '################################ Authenticated #################################'
}

function menue {
	echo '|                                                                              |'
        echo '|*************** CHOOSE WHAT KIND OF MEAL YOU WOULD LIKE TO ADD ***************|'
        echo '|                                                                              |'
        echo '|                                                                              |'
        echo '|******************************[1] P I Z Z A                                   |'
	echo '|******************************[2] B U R G E R                                 |'
	echo '|******************************[3] S A L A D                                   |'
	echo '|******************************[4] P I E                                       |'
	echo '|******************************[5] S A U S A G E                               |'
        echo '|                                                                              |'
        echo '|------------------------------------------------------------------------------|'
}

function options {
	local INSERTION
	echo 'WHAT WOULD YOU LIKE TO DO ?'>&2
	echo '[1] Show my meals'>&2
	echo '[2] Add a meal'>&2
	echo '[3] Remove a meal'>&2
	echo '[4] Exit'>&2
	read -s INSERTION
	while [ $(echo $INSERTION | grep -c "^[1-4]$") -eq 0 ]
		do
			echo 'Enter a valid option'>&2
			read -s INSERTION
		done
	echo "${INSERTION}"
}
