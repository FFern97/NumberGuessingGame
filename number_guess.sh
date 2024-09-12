#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"


echo "Enter your username:"
read USERNAME

INSERTED=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME')");

USER_EXIST=$($PSQL "SELECT name FROM users WHERE name = '$USERNAME' ");

if [[ $USER_EXIST != $USERNAME ]]
then
    echo "Welcome back, $USERNAME! You have played <games_played> games, and your best game took <best_game> guesses."
    exit 0
  
else
    echo "Welcome, $USERNAME! It looks like this is your first time here."

fi  

# Funcion para numero random: echo $(($RANDOM%100)) 

