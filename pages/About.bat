cls
call modules\navbar "About"

REM Display version on the center of the window
call plugins\batbox /g !windowCenterWidth! 3 /c 0x0a /d "!aiName!" /c 0x08 /d " - !version!" /n

REM Show credits
call plugins\batbox /g 0 5 /c 0x0f /d "Original concept & AI Core/Logistics: Rekatur" /n /d "User Interface: DewasSquid"
call plugins\batbox /g 0 8 /c 0x0f /d "Join us:" /n /c 0x01 /d "|> https://discord.gg/yXg7u8Bt"
call plugins\batbox /g 0 11 /c 0x0f /d "Follow us:" /n /c 0x01 /d "|> https://www.youtube.com/@rekatur6096" /n /d "|> https://github.com/DewasSquid"

REM Wait for mouse left click, if something else is pressed, go back.
call plugins\batbox /g 0 16 /c 0x08 /d "Press any key to go back..."

:awaitLeftClick
call plugins\getinput

REM Pressed a key instead of a click
if !errorlevel! GTR 0 goto:EOF

REM Actually clicked
set /A "input=-!errorlevel!, clickY=input >> 16, clickX=input & 0xFFFF"

REM Click was not a left click
if !clickX! GEQ 32768 goto :EOF

REM Clicked on discord link
if !clickX! GEQ 0 if !clickX! LEQ 30 if !clickY! == 9 start "" https://discord.gg/yXg7u8Bt
REM Clicked on rekatur channel
if !clickX! GEQ 0 if !clickX! LEQ 39 if !clickY! == 12 start "" https://www.youtube.com/@rekatur6096
REM Clicked on dewassquid github
if !clickX! GEQ 0 if !clickX! LEQ 32 if !clickY! == 13 start "" https://github.com/DewasSquid

goto :awaitLeftClick