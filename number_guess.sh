#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#GENERATE RANDOM NUMBER
RANDOM_NUMBER(){
    echo $(($RANDOM%3))
}

#SAVE GENERATED NUMBER IN VARIABLE
SECRET_NUMBER=$(RANDOM_NUMBER)

#REQUEST AND READ USERNAME
echo "Enter your username:"
read USERNAME

#CHECK IF USER EXISTS 
USER_EXIST=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME' ");


#FIND OUT IF USERNAME EXISTs
if [[ -z $USER_EXIST ]]
then
    echo "Welcome, $USERNAME! It looks like this is your first time here." 
    INSERTED=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME')");
  
else
    GAMES_PLAYED=$($PSQL "SELECT COUNT(games_played) FROM users")
    BEST_GAME=$($PSQL "SELECT (best_game) FROM users")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

fi


#GUESS NUMBER
echo "Guess the secret number between 1 and 1000:"
read USER_GUESS

if [[ $USER_GUESS > $SECRET_NUMBER ]]
then   
  echo "It's lower than that, guess again:"
  read USER_GUESS

else
  echo "Try again" 
  read USER_GUESS
fi
