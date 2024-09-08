#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=users -t --no-align -c"

echo "Enter your username:"
read USERNAME

INSERTED=$($PSQL "INSERT INTO users (name) VALUES ('$USERNAME')");

# Funcion para numero random: echo $(($RANDOM%100)) 

