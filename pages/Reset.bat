REM This variable stores the ID number of each data that needs to be reset to use them in the resetByID subroutine.
set "dataIDsToReset="

:askData
cls
color 07

REM Ask for which data to reset
echo Press Y to accept or press another key to decline. Press ESC to go back to the main menu.

REM Ask for each data
set /a questionNumber=1

for %%i in ("Delete cache","Reset settings","Reset window informations") do (
    echo %%~i
    
    REM Ask for a keypress (Y=121, ESC=27)
    call plugins\batbox /k
    if !errorlevel!==27 modules\menu.bat
    if !errorlevel!==121 (
        echo Y
        set dataIDsToReset=!dataIDsToReset! !questionNumber!
    )

    set /a questionNumber=!questionNumber! + 1
)

REM Ask for a confirmation by the user
call plugins\batbox /g 0 8 /c 0x0f /d "The previous content will be reset to default." /n
call plugins\batbox /c 0x0f /d "Press" /c 0x0a /d " 'N' " /c 0x0f /d "to abort. Or press" /c 0x04 /d " 'Y' " /c 0x0f /d "to confirm."

:awaitKeyPress
REM Ask for a keypress (Y=121, N=110)
call plugins\batbox /k
if !errorlevel!==110 goto :askData
if !errorlevel!==121 goto :resetSelectedData
goto :awaitKeyPress

:resetSelectedData
REM Display a warning message about the upcoming reset
call plugins\batbox /g !windowCenterWidth! !windowCenterHeight! /c 0xfc /d "Reset in progress..." /n /d "Press CTRL+C to cancel." /n /c 0x0c
timeout /t 5 /nobreak > nul

REM Reset each data one by one in order
for %%i in (!dataIDsToReset!) do (
    call :resetByID %%i
)

:resetByID
REM This subroutine checks the specified ID and reset it if found.
REM IDs inculdes :
REM    - 1 : cache (past conversations with the AI)
REM    - 2 : settings
REM    - 3 : window informations (size, width, height, ...)
REM Arguments :
REM     - ID to check for : %1

if %1==1 call :deleteCache
if %1==2 call :resetSettings
if %1==3 call :resetWinInfo
goto :EOF

:deleteCache
REM Delete the cache
for /f %%f in ('dir /b ".\cache"') do (
    cls
    echo Deleting : %%f
    del "cache\%%f"
)
goto :EOF

:resetSettings
REM TODO: Reset settings when implemented.
goto :EOF

:resetWinInfo
call main.bat
goto :EOF

call modules\menu.bat