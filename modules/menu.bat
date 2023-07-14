:menu
cls
call modules\navbar "Welcome ! Please select something."

REM Add menu options in the nav separator by looping through every page present in the "pages" folder
set "pageList="
for /f %%f in ('dir /b .\pages') do (
    set "pageName=%%~nf"
    set "pageName=!pageName:.bat=!"  
    
    set pageList=!pageList! "!pageName!"
)

REM Create a menu using cmdmenusel and the previous list of pages
call plugins\cmdmenusel 7007 !pageList!

REM Get the ID of each pages and call the selected one according to errorlevel
set /a pageId=1

for /f %%f in ('dir /b .\pages') do (
    if !pageId!==!errorlevel! (
        call pages\%%f
    )
    set /a pageId=!pageId! + 1 
)

REM In case no page was detected (somehow)
goto :menu