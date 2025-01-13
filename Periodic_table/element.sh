#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  #if atomic number is given
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "select atomic_number, name, symbol from elements where atomic_number=$1;")

  else
    #if symbol of the element is given
    if [[ ${#1} < 3 ]]
    then
      ELEMENT=$($PSQL "select atomic_number, name, symbol from elements where symbol='$1';")
    else
      #if the element's name is given
      ELEMENT=$($PSQL "select atomic_number, name, symbol from elements where name='$1';")
    fi
  fi

  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL
    do
      PROPERTY=$($PSQL "select type_id, atomic_mass, boiling_point_celsius, melting_point_celsius from properties where atomic_number=$ATOMIC_NUMBER;")

      echo "$PROPERTY" | while IFS="|" read TYPE_ID ATOMIC_MASS BOILING_POINT_CELSIUS MELTING_POINT_CELSIUS
      do
        TYPE=$($PSQL "select type from types where type_id=$TYPE_ID")

        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done

    done
  fi
fi
