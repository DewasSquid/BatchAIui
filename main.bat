@echo off
setlocal enabledelayedexpansion

REM TODO: Remote update

:config
set aiName=BatchAI
set version=0.1.2

title BatchAI

REM Load secrets/env as values
for /f "tokens=*" %%a in (.\.sec) do (
    set %%a
)

REM Load settings as values
for /f "tokens=* eol=#" %%a in (.\settings.cryuip) do (
    set /a %%a
)

REM Create a cache folder if it doesn't exist
if not exist "cache" (
    mkdir cache
)

:startup
cls

REM Get the screen dimensions
call plugins\cmdwiz getconsoledim sw
set /a windowWidth=!errorlevel! - 1

call plugins\cmdwiz getconsoledim sh
set /a windowHeight=!errorlevel! - 1

REM Get the center coordinates of the screen
set /a windowCenterWidth=!windowWidth! / 2
set /a windowCenterHeight=!windowHeight! / 2

REM Show the startup text on the center of the window
call plugins\batbox /g !windowCenterWidth! !windowCenterHeight! /c 0xa /d "!aiName!" /n
call plugins\batbox /c 0x8 /d "Press any key..."

REM Wait for user input
pause > nul

call pages\Home.bat