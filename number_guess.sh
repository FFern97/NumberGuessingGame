#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


#GENERATE RANDOM NUMBER
RANDOM_NUMBER(){
    echo $(($RANDOM%1000))

}

#SAVE GENERATED NUMBER IN VARIABLE
THIS_GAME_NUMBER=$(RANDOM_NUMBER)


#REQUEST AND READ USERNAME
echo "Enter your username:"
read USERNAME

#SAVE USERNAME IN TABLE users:
INSERTED=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME')");

GAMES_PLAYED=$($PSQL "SELECT COUNT(games_played) FROM users")
BEST_GAME=$($PSQL "SELECT COUNT(MIN(best_game)) FROM users")

USER_EXIST=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME' ");

if [[ $USER_EXIST != $USERNAME ]]
then
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    exit 0
  
else
    echo "Welcome, $USERNAME! It looks like this is your first time here."

fi  


