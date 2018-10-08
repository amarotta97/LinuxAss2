#!/bin/bash

echo "Welcome to Led_Konfigurator! "
echo "============================ "
echo "Please select an led to configure: "
echo

# For loop to return the directories within the leds directory.
cd /sys/class/leds
for files in * Quit; do
        COUNTER=$(expr $COUNTER + 1)
        echo "${COUNTER}. ${files}";
done


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

echo "Please enter a number (1-6) for the led to configure or quit: "
echo
read NUM

# Case statement to select which LED user will be using.
        case $NUM in
                1)
                        cd /sys/class/leds/input0::capslock
                        printf '%q\n' "${PWD##*/}"
                        secondmenu
                        ;;
                2)
                        cd /sys/class/leds/input0::numlock
                        printf '%q\n' "${PWD##*/}"
                        secondmenu
                        ;;
                3)
                        cd /sys/class/leds/input0::scrolllock
                        printf '%q\n' "${PWD##*/}"
                        secondmenu
                        ;;
                4)
                        cd /sys/class/leds/led0
                        printf '%q\n' "${PWD##*/}"
                        secondmenu
                        ;;
                5)
                        cd /sys/class/leds/led1
                        printf '%q\n' "${PWD##*/}"
                        secondmenu
                        ;;
                6)
                        ;;
                *)
                        echo "Invalid option!"
                        ;;

        esac

