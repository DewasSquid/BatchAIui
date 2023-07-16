:reportPage
cls
call modules\navbar "Report a bug"

REM Reeneable the cursor
call plugins\cmdwiz showcursor 1

REM Generate the questions first
call plugins\batbox /g 0 4 /c 0x0f /d "Contact informations: Enter something like your email so we can ask for more details."  /c 0x08 /d " (Press ENTER to go to next step)"
call plugins\batbox /g 0 7 /c 0x0f /d "Title: Describe the bug in a short sentence (30 characters MAX)." /c 0x04 /d " (REQUIRED)"
call plugins\batbox/g 0 10 /c 0x0f /d "Description: Describe what the bug was, what were you doing when it occured, etc." /c 0x04 /d " (REQUIRED)"

REM Ask for contacts
call plugins\batbox /g 0 5 /c 0x07 & set /p userContact=
REM Check if the contact value is empty
if "!userContact!"=="" set userContact=Not specified.

REM Ask for the title
call plugins\batbox /g 0 8 /c 0x07 & set /p bugTitle=

REM Check if the length of the title is more than 30 chars or empty, if so, refresh
plugins\cmdwiz stringlen !bugTitle! 
if !errorlevel! GTR 30 goto :reportPage
if !errorlevel!==0 goto :reportPage

REM Ask for the description
call plugins\batbox /g 0 11 /c 0x07 & set /p bugDescription=
REM Check if a description was provided
plugins\cmdwiz stringlen !bugDescription!
if !errorlevel!==0 goto :reportPage

REM Ask for confirmation
cls
echo You confirm the following informations (Y to confirm, ESC to leave, other keys to go to back.):
echo.
echo YOU: !userContact!
echo BUG: !bugTitle!
echo !bugDescription!

REM Ask for a keypress (Y=121, ESC=27)
call plugins\batbox /k
if !errorlevel!==121 goto :sendWebhook
if !errorlevel!==27 goto :EOF
goto :reportPage

:sendWebhook
REM Send the bug report using webhook
REM Prepare request infos
echo Content-Type: application/json>cache\r_header.txt
(
   echo {
   echo    "embeds": [{
   echo       "title": "New bug report",
   echo       "description": "Author contact: `!userContact!`",
   echo       "fields": [
   echo          {
   echo             "name": "Title",
   echo             "value": "!bugTitle!",
   echo             "inline": false
   echo          },
   echo          {
   echo             "name": "Description",
   echo             "value": "!bugDescription!",
   echo             "inline": false
   echo          },
   echo       ]
   echo    }]
   echo }
)>cache\r_body.json

REM Send the message
call modules\winhttpjs !bugWebhookLink! -method POST -header cache\r_header.txt -body-file cache\r_body.json -saveTo cache\http_log.txt
pause