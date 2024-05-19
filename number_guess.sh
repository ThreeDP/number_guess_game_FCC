#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))

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
  MAIN_GAME
}

MAIN_GAME() {
  if [[ $1 ]]
  then
    echo "$1"
  else
    echo "Guess the secret number between 1 and 1000:"
  fi
  echo -e "SECRET NUMBER: $SECRET_NUMBER"
  read GUESS_NUMBER
  if [[ $SECRET_NUMBER -lt $GUESS_NUMBER ]]
  then
    MAIN_GAME "It's lower than that, guess again:"
  elif [[ $SECRET_NUMBER -gt $GUESS_NUMBER ]]
  then
    MAIN_GAME "It's higher than that, guess again:"
  else
    echo "You guessed it in <number_of_guesses> tries. The secret number was $SECRET_NUMBER. Nice job!"
  fi
}

MAIN_MENU