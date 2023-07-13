@echo off
:a
call plugins\batbox /k
echo %errorlevel%
goto :a