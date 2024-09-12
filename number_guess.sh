#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#GENERATE RANDOM NUMBER
RANDOM_NUMBER(){
    echo $(($RANDOM%10+1))
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
    INSERTED=$($PSQL "INSERT INTO users (name, games_played, best_game) VALUES ('$USERNAME', 0, NULL)");
  
else
    GAMES_PLAYED=$($PSQL "SELECT games_played FROM users")
    BEST_GAME=$($PSQL "SELECT best_game FROM users")
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

fi


#GUESS NUMBER
echo "Guess the secret number between 1 and 1000:"
read USER_GUESS


while [[ $USER_GUESS != $SECRET_NUMBER ]]
do

if ! [[ $USER_GUESS =~ ^[0-9]+$ ]]
then 
  echo "That is not an integer, guess again:"
  read USER_GUESS
else

  if [[ $USER_GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read USER_GUESS

  elif [[ $USER_GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
    read USER_GUESS
  fi

fi  

done

UPDATE_GAMES=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE name = '$USERNAME' ")
COUNT_GAMES=$(PSQL "SELECT games_played FROM users WHERE name = '$USERNAME'")
echo "You guessed it in $COUNT_GAMES tries. The secret number was $SECRET_NUMBER. Nice job!"
 




