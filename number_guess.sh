#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$($RANDOM % 1000 + 1)

echo -e "\n~~~~~ Number Guess Game ~~~~~\n"

MAIN_MENU() {
  echo -e "\nEnter your username:"
  read USERNAME
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  if [[ -z $USER_ID ]]
  then
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    echo $INSERT_USER_RESULT
  else
    GAMES_INFO=$($PSQL "SELECT COUNT(*), MIN(number_of_guesses) FROM users RIGHT JOIN guess_games USING(user_id) WHERE user_id = $USER_ID")
    echo $GAMES_INFO
  fi
}

MAIN_MENU