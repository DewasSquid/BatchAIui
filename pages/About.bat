REM TODO: ckick links
cls
call modules\navbar "About"

call plugins\batbox /g !windowCenterWidth! 3 /c 0x0a /d "!aiName!" /c 0x08 /d " - !version!" /n

call plugins\batbox /g 0 5 /c 0x0f /d "Original concept & AI Core/Logistics: Rekatur" /n /d "User Interface: DewasSquid"
call plugins\batbox /g 0 8 /c 0x0f /d "Join us:" /n /c 0x01 /d "|> https://discord.gg/yXg7u8Bt"
call plugins\batbox /g 0 11 /c 0x0f /d "Follow us:" /n /c 0x01 /d "|> https://www.youtube.com/@rekatur6096" /n /d "|> https://github.com/DewasSquid"

call plugins\batbox /g 0 16 /c 0x08 /d "Press any key to go back..."
pause > nul