#!/bin/bash

#######################################################################################################################

# Let's add some colour stuff, all lowercase vairables are for the text itself and UPPERCASE are for the background.
source ./colors.sh

########################################################################################################################

# Common variables that we will use through out the game

player_died=$(printf "You have %s%s died. %s" "$red" "$bold" "$normal")
enemy_died=$(printf "You have %s%s won!. %s" "$green" "$bold" "$normal")

# Common functions that we will use through out the game

# Enemy attack calculation
enemy_attack_calc() {
    local max_range=2  # For range 0-1
    local enemy_attack=$(openssl rand -hex 2 | tr -d '\n' | awk '{ print "0x" $1 }' | xargs printf "%d")
    printf "%d" $((enemy_attack % max_range))  # we'll use printf here with the %d option to specifiy we always want a decimal number. Using printf will make the output predictible each and everytime.
}

#######################################################################################################################
# Start of the game

printf "$player_died \n\n"

#######################################################################################################################
# First battle.

# Battle mechanics part 1
# Enemy attack.
# Generate a random number between 0 and 1
enemy_attack=$(openssl rand -hex 2 | tr -d '\n' | awk '{ print "0x" $1 }' | xargs printf "%d")
enemy_attack=$((enemy_attack % 2))  # Limit the number to the range 0-1
#printf "Your random number: %d\n" "$enemy_attack"

# Battle mechanics part 2
# Player attack.
printf "The first enemy is here, you need to pick a number between 0 and 1 \n"

# Let's create a loop to validate the player input.
while true; do
    read -p "Enter your attack (0 or 1): " player_attack
    if [[ $player_attack =~ ^[0-1]$ ]]; then  # Check if input is 0 or 1
        break
    else
        printf "%s%s%s Invalid input, please enter 0 or 1. %s \n" "$red" "$bold" "$reverse" "$normal"
    fi
done

# Battle mechanics part 3
# If the enemy attack is less than or equal to the player attack, the player wins.
if [[ $enemy_attack -le $player_attack ]]; then
    printf "\n%s (your attack was %d the enemy attack was %d)\n\n" "$enemy_died" "$player_attack" "$enemy_attack"
else
    printf "\n%s (the enemy attack was %d the player attack was %d)\n\n" "$player_died" "$enemy_attack" "$player_attack"
    exit 1
fi

#######################################################################################################################
# Second battle.

# Battle mechanics part 1
# Let's get the enemy's attack from the function.
enemy_attack=$(enemy_attack_calc)
enemy_attack=$(( enemy_attack + 2 ))

# Battle mechanics part 2
# Player attack.
printf "The second enemy is here, you need to pick a number between 0 and 9 \n"

# Let's create a loop to validate the player input.
while true; do
    read -p "Enter your attack (0-9): " player_attack
    if [[ $player_attack =~ ^[0-9]$ ]]; then  # Check if input is 0 or 9
        break
    else
        printf "%s%s%s Invalid input, please enter 0 and 9. %s \n" "$red" "$bold" "$reverse" "$normal"
    fi
done

# Battle mechanics part 3
# If the enemy attack is less than or equal to the player attack, the player wins.
if [[ $enemy_attack -le $player_attack ]]; then
    printf "\n%s (your attack was %d the enemy attack was %d)\n\n" "$enemy_died" "$player_attack" "$enemy_attack"
else
    printf "\n%s (the enemy attack was %d the player attack was %d)\n\n" "$player_died" "$enemy_attack" "$player_attack"
    exit 1
fi

#######################################################################################################################
# Third battle.

# Battle mechanics part 1
# Let's get the enemy's attack from the function.
enemy_attack=$(enemy_attack_calc)
enemy_attack=$(( enemy_attack + 75 ))

# Battle mechanics part 2
# Player attack.
printf "The third enemy is here, you need to pick a number between 000 and 999 \n"

# Let's create a loop to validate the player input.
while true; do
    read -p "Enter your attack (000-999): " player_attack
    if [[ $player_attack =~ ^[0-9]{1,3}$ ]]; then  # Check if input is 000 to 999
        break
    else
        printf "%s%s%s Invalid input, please enter 0 and 9. %s \n" "$red" "$bold" "$reverse" "$normal"
    fi
done

# Battle mechanics part 3
# If the enemy attack is less than or equal to the player attack, the player wins.
#if [[ $enemy_attack -le $player_attack ]]; then
#    printf "\n%s (your attack was %d the enemy attack was %d)\n\n" "$enemy_died" "$player_attack" "$enemy_attack"
#else
#    printf "\n%s (the enemy attack was %d the player attack was %d)\n\n" "$player_died" "$enemy_attack" "$player_attack"
#fi

if [[ $player_attack -eq 42 ]]; then
    printf "\n%s %s%s%s (CHEAT CODE ACTIVATED!) %s\n\n" "$enemy_died" "$bold" "$red" "$WHITE" "$normal"
elif [[ $enemy_attack -le $player_attack ]]; then
    printf "\n%s (your attack was %d the enemy attack was %d)\n\n" "$enemy_died" "$player_attack" "$enemy_attack"
else
    printf "\n%s (the enemy attack was %d the player attack was %d)\n\n" "$player_died" "$enemy_attack" "$player_attack"
    exit 1
fi