REM Create a navbar on top of the window
REM Arguments :
REM     ["PAGE NAME"] (%1) :
REM         The name of the current page

REM Hide some console features
call plugins\cmdwiz showcursor 0

REM Show the page title on top of the navbar
call plugins\batbox /g 1 1 /c 0xa /d "!aiName!" /c 0x8 /d " - " /c 0xf /d %1

REM Create a navbar by filling the lower top window with colored characters as a delimitation
for /l %%x in (0, 1, !windowWidth!) do (
    call plugins\batbox /g %%x 2 /c 0x88 /d "X"
)

call plugins\batbox /c 0x07