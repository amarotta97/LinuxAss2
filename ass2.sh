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
 
