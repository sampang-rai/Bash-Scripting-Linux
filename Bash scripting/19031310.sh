#!/bin/bash

# declaring a function that displays the continue message.
continue_again(){
	echo ""
	echo "+================================+"
	echo "|    Do you want to continue?    |"
	echo "|           Yes or No            |"
	echo "+================================+"
	echo -e "Yes or No: \c"
	read answer

	#declearing a conditional statements that helps to operate
	if [[ $answer == "Yes" || $answer == "yes" ]]
	then
		guess_team
	elif [[ $answer == "No" || $answer == "no" ]]
	then
		echo -e "\n+===============================+"
		echo -e "      >>>Program Closed<<<        "
		echo -e "     >>>Have a great day!<<<     "
		echo -e "              >_                 "
		echo -e "+===============================+\n"
		exit
	else
		continue_again
	fi

}

# declaring a function that read player details
read_player_details(){
	if [[ -f $1 ]]
	then
		cat $1
		continue_again
	else
		echo "+==========================================+"
		echo "    >>>Sorry! File could not be found<<<    "
		echo "       >>>Choose another player<<<          "
		echo "+==========================================+"
		echo ""
		guess_team
	fi
}

# declaring a function that shows player details with available option
player_details(){
	PS3="-> Select any one player: "
	select pCode in $p1 $p2 $p3
	do
		case $pCode in
			'LM') read_player_details LM;;
			'NJ') read_player_details NJ;;
			'KC') read_player_details KC;;
			'ZZ') read_player_details ZZ;;
			'HK') read_player_details HK;;
			*)
				echo -e "\n+=========================================+"
				echo -e "    >>>Please select a valide number<<<    "
				echo -e "+=========================================+\n"
		esac
	done
}
# declaring a function that shows the choosen player
select_player(){
	x=false
			#creating the infinite loop to get the correct player code
			until [ $x = true ]
			do
				echo -e "-> Enter Players code: \c"
				read p1 p2 p3
				players=($p1 $p2 $p3)
				allPlayers=(LM NJ KC ZZ HK)

				if [ ${#players[@]} -eq 3 ]
				then
					# checking if the players enter by user are not repeated
					if [[ "${p1}" == "${p2}" || "${p2}" == "${p3}" || "${p1}" == "${p3}" ]]
					then
						echo -e "\n+============================================+"
						echo -e "    >>>Remove the repeating Players code<<<    "
						echo -e "              >>>>Try Again!<<<               "
						echo -e "+============================================+\n"
					else
						i=false
						for player_1 in "${players[@]}"
						do
							l=false
							for player_2 in "${allPlayers[@]}"
							do
								if [[ $player_1 == $player_2 ]]
								then
									l=true
									i=true
									continue
								fi
							done
							if [[ $l == false ]]
							then
								i=false
								echo "+===================================+"
								echo "    >>> Not in the player list<<<   "
								echo "+===================================+"
								break
							fi
						done
						if [[ $i == true ]]
						then
							player_details
						fi
					fi
				else
					echo -e "\n+==============================+"
					echo -e "    >>>select three players<<<    "
					echo -e "+================================+\n"
				fi
			done
}
#
select_team(){
	team=""

	# creating an infinite loop till the user enters the correct country code
	until [[ $team == "NEP" ]]
	do
		echo  -e "-> Enter Country Code: \c"
		read team
		if [[ $team == "NEP" ]]
		then
			echo ""
			echo "+=======================================+"
			echo "    You guess the best football team.    "
			echo "+=======================================+"
			echo ""
			echo "Choose any three players"
			echo "+----------------------------+"
			echo "|       Player       Code    |"
			echo "+----------------------------+"
			echo "|    Lionel Messi     LM     |"
			echo "|    Neymar Junior    NJ     |"
			echo "|    Kiran Chemjong   KC     |"
			echo "|    Zheng Zhi        ZZ     |"
			echo "|    Harry Kane       HK     |"
			echo "+----------------------------+"
			select_player

			elif [[ $team == 'BRZ' ]]
				then
					echo -e "\n  >>>Select the best team<<<"
					echo -e "        >>>Try Again!<<<\n"
			elif [[ $team == 'ARG' ]]
				then
					echo -e "\n   >>>Select the best team<<<"
					echo -e "         >>>Try Again!<<<\n"
			elif [[ $team == 'CHI' ]]
				then
					echo -e "\n   >>>Select the best team<<<"
					echo -e "         >>>Try Again!<<<\n"
			elif [[ $team == 'ENG' ]]
				then
					echo -e "\n   >>>Select the best team<<<"
					echo -e "         >>>Try Again!\n"
			else
				echo "+=====================================+"
				echo "    >>>Please! Enter valid code<<<<    "
				echo "+=====================================+"
		fi
	done
}

guess_team(){
	echo
	echo " Guess the best football team "
	echo "+------------------------------+"
	echo "|     Country        Code      |"
	echo "+------------------------------+"
	echo "|     Brazil         BRZ       |"
	echo "|     Argentina      ARG       |"
	echo "|     Nepal          NEP       |"
	echo "|     China          CHI       |"
	echo "|     England        ENG       |"
	echo "+------------------------------+"
	select_team
}

Name=$1
ID=$2

# checking if the parameter is null or not
if [ -z $ID ]
then
	echo "+=========================================+"
	echo "    >>>Please enter your Name and ID<<<    "
	echo "         >>>Program Closed<<<         "
	echo "+=========================================+"

	exit
fi

tParameter=$3
# checking if the third paramete is exists or not
if [ "$tParameter" != "" ]
then
	echo "+=========================================+"
	echo "    !!! Third parameter not allowed !!!    "
	echo "         >>>Program Closed<<<         "
	echo "+=========================================+"
	exit
fi

sKey=""
# taking the user input for five times
for user in {1..5}
do
	echo -e "Enter the password: \c"
	read -s pw
	if [[ $pw == $sKey ]]
	then
		echo ""
		echo "+-----------------------------------+"
		echo "               WELCOME               "
		echo "+-----------------------------------+"
		echo "          Name: $1		   "
		echo "          ID  : $2	           "
		echo "                                     "
		date +"          Time: %T                  "
		date +"          Date: %Y-%m-%d            "
		echo "+-----------------------------------+"
		guess_team

		break
	else
		echo -e "\n+=============================+"
		echo -e "     !!! Wrong Password !!!      "
		echo -e "          Try Again!             "
		echo -e "    Remaining time: `expr 5 - $user` "
		echo -e "+===============================+"
	fi
done
