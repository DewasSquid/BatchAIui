
REM TODO: Display settings
cls
call modules\navbar "Settings"

REM Display settings
for /f "tokens=* eol=#" %%s in (.\settings.cryuip) do (
    echo %%s
)

pause