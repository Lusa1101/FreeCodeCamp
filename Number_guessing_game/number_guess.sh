#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

RANDOM_NUMBER=$(shuf -i 1-1000 -n 1)

echo -e "Enter your username:"
read USERNAME

#Get user name from the database
USER_ID=$($PSQL "select user_id from users where username='$USERNAME'")
USER_ID=$(echo $USER_ID | sed -r 's/([0-9]+).*/\1/')

#Check if username exists
if [[ -z $USER_ID ]]
then
  #If username does not exist
  echo -e "Welcome, $USERNAME! It looks like this is your first time here.\n"

  #Register user
  INSERT_USER_RESULT=$($PSQL "insert into users(username) values ('$USERNAME')")
  if [[ $INSERT_USER_RESULT="INSERT 0 1" ]]
  then
    USER_ID=$($PSQL "select user_id from users where username='$USERNAME'")
  fi
else
  #If username exists
  GAMES_PLAYED=$($PSQL "select count(*) from games where USER_ID=$USER_ID")
  GAMES_PLAYED=$(echo $GAMES_PLAYED | sed -r 's/([0-9]+).*/\1/')
  BEST_GAME=$($PSQL "select min(number_of_guesses) from games where USER_ID=$USER_ID")
  Best_GAME=$(echo $BEST_GAME | sed -r 's/([0-9]+).*/\1/')
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.\n"
fi

#Create loop for the course of the game
COUNT=0
CONTINUE=1

echo "Guess the secret number between 1 and 1000:"
read GUESS

while [ $CONTINUE=1 ];
do
  #INCREMENT $COUNT
  ((COUNT++))

  #If guess its not a number
  if [[ ! "$GUESS" =~ ^[0-9]+$ ]]
  then
    echo -e "That is not an integer, guess again:"
    read GUESS
  fi

  #If guess is correct
  if [[ "$GUESS" = "$RANDOM_NUMBER" ]]
  then
    #Insert game record
    INSERT_GAME_RESULT=$($PSQL "insert into games(user_id, number_of_guesses) values ($USER_ID, $COUNT)")
    if [[ $INSERT_GAME_RESULT="INSERT 0 1" ]]
    then
      echo "You guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
      exit 
    fi
  else
    #Comments after guessing
    if [[ $GUESS -lt $RANDOM_NUMBER ]]
    then
      echo -e "It's higher than that, guess again:"
      read GUESS
    else
      echo -e "It's lower than that, guess again:"
      read GUESS
    fi
  fi

done

GET_GUESS() {
  if [[ $1 ]]
  then
    echo $1
    read GUESS
  else
    echo "Guess the secret number between 1 and 1000:"
    read GUESS
  fi

  echo $GUESS
}