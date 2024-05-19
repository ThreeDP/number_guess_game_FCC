#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))

echo -e "\n~~~~~ Number Guess Game ~~~~~\n"

MAIN_MENU() {
  # get username
  echo "Enter your username:"
  read USERNAME
  USERNAME="${USERNAME:0:22}"

  # get user id
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

  # if user not exist
  if [[ -z $USER_ID ]]
  then
    # insert username
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    if [[ $INSERT_USER_RESULT = "INSERT 0 1" ]]
    then
      # get user id
      USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
      # welcome user
      echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
    fi
  else

    # get number of games and best game
    GAMES_INFO=$($PSQL "SELECT COUNT(*), MIN(number_of_guesses) FROM users RIGHT JOIN guess_games USING(user_id) WHERE user_id = $USER_ID")
    IFS="|"
    read -r GAMES_PLAYED BEST_GUESS <<< $GAMES_INFO
    IFS=" "

    # show initial message
    if [[ $GAMES_PLAYED = '0' ]]
    then
      BEST_GUESS=0
    fi
    echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GUESS guesses."
  fi
  MAIN_GAME "" 0
}

MAIN_GAME() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nGuess the secret number between 1 and 1000:"
  fi
  read GUESS_NUMBER
  # if is not a number
  if [[ ! $GUESS_NUMBER =~ ^[0-9]+$ ]];
  then
    MAIN_GAME "That is not an integer, guess again:" $2
  fi

  # if number is higher than secret number.
  if [[ $SECRET_NUMBER -lt $GUESS_NUMBER ]];
  then
    MAIN_GAME "It's lower than that, guess again:" $(($2 + 1))

  # if number is lower than secret number.
  elif [[ $SECRET_NUMBER -gt $GUESS_NUMBER ]];
  then
    MAIN_GAME "It's higher than that, guess again:" $(($2 + 1))

  # if number is the secret number.
  else
    TRIES=$(($2 + 1))
    INSERT_GUESS_GAME_RESULT=$($PSQL "INSERT INTO guess_games(user_id, number_of_guesses, secret_number) VALUES($USER_ID, $TRIES, $SECRET_NUMBER)")
    if [[ $INSERT_GUESS_GAME_RESULT = "INSERT 0 1" ]]
    then
      echo -e "\nYou guessed it in $TRIES tries. The secret number was $SECRET_NUMBER. Nice job!"
    fi
  fi
}

MAIN_MENU
