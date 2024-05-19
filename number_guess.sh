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
    if [[ $INSERT_USER_RESULT = "INSERT 0 1" ]]
    then
      echo "Welcome, $USERNAME! It looks like this is your first time here."
    fi
  else
    GAMES_INFO=$($PSQL "SELECT COUNT(*), MIN(number_of_guesses) FROM users RIGHT JOIN guess_games USING(user_id) WHERE user_id = $USER_ID")
    IFS="|"
    read -r GAMES_PLAYED BEST_GAME <<< $GAMES_INFO
    if [[ $GAMES_PLAYED = '0' ]]
    then
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games."
    else
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    fi
  fi
}

MAIN_MENU