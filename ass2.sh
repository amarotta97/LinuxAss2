#!/bin/bash

echo "Welcome to Led_Konfigurator! "
echo "============================ "
echo "Please select an led to configure: "
echo

# *** Task 3 Menu
# Function to return the menu of selected LED.
# To be generated after user selects which LED they will use from the previous menu (mainMenu)
# The expected outcome of this function is that it will display the options that are defined here, and once a user
# selects their option it will complete the task that is defined by the option, it will then call the second case
function secondMenu(){
        echo "===================="
        echo "1) turn on"
        echo "2) turn off"
        echo "3) associate with a system event"
        echo "4) associate with the performance of a process"
        echo "5) stop association with a process' performance"
        echo "6) quit to main menu"
        echo "Please enter a number (1-6) for your choice: "
        echo

	# While loop to stay within the menu after execution of user selected operation 
	while true; do
        	secondCase
	done
}

# *** Task 3 Case
# Function for the second case to select what to do with the selected LED.
# The expected outcome of this menu is to complete the option that has been selected by the user.
# This will complete the tasks for the selected LED, which is associated with the function (secondMenu)
function secondCase(){
	# read the user input to use for case statement
        read INPUT
                case $INPUT in
                        1)
				# *** Task 4
				# 1st option: turn ON the LED in that working directory
                                cwd=$(pwd)
                                echo 1 | sudo tee $cwd/brightness > /dev/null
				secondMenu
                                ;;
                        2)
				# *** Task 4
				# 2nd option: turn OFF the LED in that working directory
                                cwd=$(pwd)
                                echo 0 | sudo tee $cwd/brightness > /dev/null
				secondMenu
                                ;;
                        3)
				# 3rd option: Will call the trigger event associated with the selected LED
                                while true; do
	                                triggerMenu
        			done
	                        ;;
                        4)
				# Work in progress
                                task6
                                ;;
                        5)
				# Work in progress
                                echo "5"
                                ;;
                        6)
				# 6th option should return user to main menu (mainMenu)
				mainMenu
				;;
                esac
	}

# *** Task 2
# Function that will generate menu from the directories in required folder: Requirement 2
# That required folder being: /sys/class/leds
# The expectation of this menu is that the user can select which LED they would like to use,
# The function will then call the secondMenu for user to decide what they want to do with that selected LED
function mainMenu(){
# Select statement, dynamic so that it will change directories into the selected option, from the generated menu
        cd /sys/class/leds
        COLUMNS=+1

	# PS3 will be the statement that displays what the user should do at the given menu
	PS3="Please enter a number that corresponds to the LED to configure or quit: "

        select files in * Quit;
        # Case statement to select which LED user will be using, which will then print the secondMenu for user.
        do
                case $files in

			"Quit")
				echo "Exitting."
				;;
                        *)
                                cd "$files"
                                echo
                                printf '%q\n' "${PWD##*/}"
                                secondMenu
                                ;;
                esac
        done


}

# ***Task 5
# Function to associate LED with a system event (Requirement 5)
# Expected result of this function is that it will print the events from the trigger file using cat command
# The function will then read the event that is produced by the menu that the user selects, and echo that
# Command to the trigger file to complete the task selected.
function triggerMenu(){
        echo "Associate Led with a system Event"
        echo "===================================="
        echo "Available events are: "
        echo "----------------"

	PS3="Please select an option (1-33):"

	# Select which will print the events that are allowed by the trigger file from the current working directory
        cwd=$(pwd)
        select event in $(cat $cwd/trigger) "Quit to previous menu";

	# Case statement which will select the event from user input
	# and echo it into the trigger file of the current working directory
	do
                case $event in
			"Quit to previous menu")
				echo "Returning to previous menu."
				secondMenu
				;;
	              	**)
                               	echo $event | sudo tee $cwd/trigger
				triggerMenu
                                ;;
		esac
	done
}

# Task 6
function task6(){
	echo "Associated LED with the performance of a process"
	echo "-----------------------------------"
	echo "Please enter the name of the program to monitor (partial names are ok): "

	
}

mainMenu

