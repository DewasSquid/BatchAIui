
REM TODO: Edit settings
cls
call modules\navbar "Settings"

REM Display settings
set /a currentDisplayY=3
for /f "tokens=1,2 eol=# delims==" %%a in (.\settings.cryuip) do (
    REM Replace the "_" in the current setting's name by spaces 
    set settingName=%%a
    set settingName=!settingName:_= !

    REM Convert the setting's state to something more comprehensible (1=ON, 0=OFF) 
    set settingState=%%b
    set settingState=!settingState:1=ON!
    set settingState=!settingState:0=OFF!

    REM Set the color of the state text according to the current setting's state
    if !settingState!==ON (
        set settingStateColor=0x0a
    ) else (
        set settingStateColor=0x0c
    )

    REM Display the setting name and the setting state using 2 calls (too long for one line)
    call plugins\batbox /g 0 !currentDisplayY! /c 0x0f /d "!settingName! "
    call plugins\batbox /g !windowCenterWidth! !currentDisplayY! /c !settingStateColor! /d "!settingState!"
    
    REM Go one line below
    set /a currentDisplayY=!currentDisplayY! + 1
)

pause>nul