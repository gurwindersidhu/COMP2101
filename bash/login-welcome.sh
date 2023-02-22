#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
USER="gurwinder"
hostname="$(hostname)"

#################
# date and time #
#################
day=$(date +"%A")
date=$(date +"%I:%M %p")

#################
#    titles     #
if [ $day == "Monday" ]
then
  title="Monday might be busy"
elif [ $day == "Tuesday" ]
then
  title="Tuesday might be OK"
elif [ $day == "Wednesday" ]
then
  title="Wednesday might be Good"
elif [ $day == "Thursday" ]
then
  title="Thursday might be Lucky"
elif [ $day == "Friday" ]
then
  title="Friday might be Weekend"
 elif [ $day == "Saturday" ]
then
  title="Saturday might be Sleepy Day"
else 
  title="Sunday is FREE"
fi

# Main        #
###############
cat <<EOF

Welcome to planet $hostname, "$title $USER!"
It is $day at $date.

cowsay $login

EOF
