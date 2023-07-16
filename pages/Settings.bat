:settingsPage
cls
call modules\navbar "Settings"

REM Generate a list of settings followed by their states
set "settingList="
for /f "tokens=1,2 delims==" %%a in (.\settings.cryuip) do (
    set settingName=%%a
    set settingName=!settingName:_= !

    REM Convert the setting's state to something more comprehensible (1=ON, 0=OFF) 
    set settingState=%%b
    set settingState=!settingState:1=ON!
    set settingState=!settingState:0=OFF!

    REM Add spacing after setting name to display setting state
    call plugins\cmdwiz stringlen "!settingName!"
    set settingNameLength=!errorlevel!

    set /a spacingToAdd=!windowCenterWidth! - !settingNameLength!
    set "settingSpacing="
    for /l %%i in (0, 1, !spacingToAdd!) do (
        set "settingSpacing=!settingSpacing! "
    )
    set settingDisplay=!settingName!!settingSpacing![!settingState!]

    REM Add new string combining state and name to list
    set settingList=!settingList! "!settingDisplay!"
)

REM Display settings list using cmdmenusel
call plugins\cmdmenusel 7007 !settingList! "Go back"

REM Get the ID of each settings and modify the state of the selected one according to errorlevel
set /a settingId=1
for /f "tokens=1,2 delims==" %%a in (.\settings.cryuip) do (
    if !settingId!==!errorlevel! (
        set settingName=%%a
        set settingState=%%b
        
        if !settingState!==1 (
            set newSettingState=0
        ) else (
            set newSettingState=1
        )
        
        call plugins\replaceline "settings.cryuip" !settingId! "!settingName!=!newSettingState!"
        goto :settingsPage
    )
    set /a settingId=!settingId! + 1
)

call modules\menu.bat