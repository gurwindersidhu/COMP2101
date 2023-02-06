#!/bin/bash
#
# this script rolls a pair of six-sided dice and displays both the rolls

# Tell the user we have started processing
echo "Rolling..."

# Task 1:
#  put the number of sides in a variable which is used as the range for the random number
range=6
#  put the bias, or minimum value for the generated number in another variable
bias=1
#  roll the dice using the variables for the range and bias i.e. RANDOM % range + bias
die1=$(( RANDOM % range + bias ))
die2=$(( RANDOM % range + bias ))
# Task 2:
#  generate the sum of the dice
sum=$((die1 + die2))
#  generate the average of the dice
average=$((sum / 2))
#  display a summary of what was rolled, and what the results of your arithmetic were
echo "Rolled $die1, $die2"

echo "The sum of dice = $sum"
echo "The average of dice = $average"



