cls
call modules\navbar "Home"

REM Display a small help text
call plugins\batbox /g 0 2 /c 0x87 /d "Type in ':q' to leave type mode."

REM Reeneable console features
call plugins\cmdwiz showcursor 1

REM Create convo files if they do not exist
if not exist "cache\convo_line.cryuip" (
    REM Input in the starting position of messages in conversation
    echo 6 > cache\convo_line.cryuip
)
if not exist "cache\convo.cryuip" echo. > cache\convo.cryuip

REM Take the line number value in convo_line.cryuip
set /p currentMessageY=<cache\convo_line.cryuip

REM Read each line in convo.cryuip and execute batbox plugin
for /f "tokens=*" %%l in (cache\convo.cryuip) do call plugins\batbox %%l

:askPrompt
REM Generate an input widget
for /l %%x in (0, 1, !windowWidth!) do (
    call plugins\batbox /g %%x 3 /c 0xff /d "X"
)

REM Change the text color to the opposite of the input widget so it can be readable and ask for a prompt
call plugins\batbox /c 0xf0 /g 0 3 & set /p prompt=Prompt:

REM Check if the user wish to exit the typing mode
if "!prompt!"==":q" (
    REM Reset the color before going to the menu
    call plugins\batbox /c 0x07
    call modules\menu.bat
)

REM Display the user and bot message on conversation, also save the convo as well as the current line number in case of a restart
REM Display the date
set convoDateDisplay=/g 0 !currentMessageY! /c 0x08 /d "The !date! at !time!"
call plugins\batbox !convoDateDisplay!

REM Add one line to the line count
set /a currentMessageY=!currentMessageY! + 1

REM User's message
set convoUserMessage=/g 0 !currentMessageY! /c 0x04 /d "> !prompt!" /n
call plugins\batbox !convoUserMessage!

REM Bot's message
set convoBotMessage="This is supposed to be where the ai respond. YAY !!"
call plugins\batbox /c 0x0a
call plugins\typewriter !convoBotMessage! 10
set convoBotMessage=/c 0x0a /d !convoBotMessage!

REM Line number
set /a currentMessageY=!currentMessageY! + 4

REM Save everything
echo !convoDateDisplay! >> cache\convo.cryuip
echo !convoUserMessage! >> cache\convo.cryuip
echo !convoBotMessage!  >> cache\convo.cryuip
echo !currentMessageY! > cache\convo_line.cryuip

goto :askPrompt