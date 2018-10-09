#!/bin/bash

echo "Welcome to Led_Konfigurator! "
echo "============================ "
echo "Please select an led to configure: "
echo

# Function to return the menu of selected LED.
function secondmenu(){
        echo "===================="
        echo "1) turn on"
        echo "2) turn off"
        echo "3) associate with a system event"
        echo "4) associate with the performance of a process"
        echo "5) stop association with a process' performance"
        echo "6) quit to main menu"
        echo "Please enter a number (1-6) for your choice: "
        echo

        secondcase
}


# Function for the second case to select what to do with the selected LED.
function secondcase(){
        read INPUT
                case $INPUT in
                        1)
                                cwd=$(pwd)
                                echo $cwd/brightness
                                echo 1 | sudo tee $cwd/brightness
                                ;;
                        2)
                                cwd=$(pwd)
                                echo $cwd/brightness
                                echo 0 | sudo tee $cwd/brightness
                                ;;
                        3)
                                echo "3"
                                triggermenu
                                ;;
                        4)
                                echo "4"
                                ;;
                        5)
                                echo "5"
                                ;;
                        6)
                                echo "Return to main menu"
                esac
        }

# Function that will generate menu from the directories in required folder: Requirement 2
function generateMenu(){
# Select statement, dynamic so that it will change directories into the selected option, from the generated menu
        cd /sys/class/leds
        COLUMNS=+1
        select files in * Quit;

        # Case statement to select which LED user will be using.
        do
                case $files in
                        *)
                                cd "$files"
                                echo
                                printf '%q\n' "${PWD##*/}"
                                secondmenu
                                ;;
                esac
        done

        echo "Please enter a number (1-6) for the led to configure or quit: "
        echo

}

# Function to associate LED with a system event (Requirement 5)
function triggermenu(){
        echo "Associate Led with a system Event"
        echo "===================================="
        echo "Available events are: "
        echo "----------------"

        cwd=$(pwd)
        select event in $(cat $cwd/trigger) "Quit to previous menu";

        do
                case $event in
                        *)
                                echo $event | sudo tee $cwd/trigger
                                ;;
                esac
        done
}

generateMenu

