#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#Function to insert 

#Truncate table
echo $($PSQL "truncate teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $ROUND != round ]]
  then
    #Handle the teams

    #For the winner
    WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
    if [[ -z $WINNER_ID ]]
    then
      INSERT_TEAM=$($PSQL "insert into teams(name) values('$WINNER')")
      if [[ $INSERT_TEAM = "INSERT 0 1" ]]
      then
        echo Inserted into teams $WINNER
        WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      fi
    else
        TEAM_ID=null
    fi

    #For the opponent
    OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_TEAM=$($PSQL "insert into teams(name) values('$OPPONENT')")
      if [[ $INSERT_TEAM = "INSERT 0 1" ]]
      then
        OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
        echo Inserted into teams $OPPONENT
      fi
      else
        TEAM_ID=null
    fi
    
    #Handle the games
    INSERT_GAME=$($PSQL "insert into games(year,round,winner_id, opponent_id, winner_goals, opponent_goals) values ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_GAME = "INSERT 0 1" ]]
    then
      echo Inserted into games $WINNER vs $OPPONET
    fi

  fi
done