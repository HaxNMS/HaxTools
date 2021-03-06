@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set SRC=%~1
set ID=%~2

REM use the name of the parent directory for the pak file
set NAME=%~dp1

REM -------------------------------------------------------------
REM EXECUTE

set SCRIPT_DIR=%~dp0
set PSARC="%SCRIPT_DIR%\bin\psarc.exe"

call "%SCRIPT_DIR%\PSARC_PACK.BAT" "%SRC%" "%ID%"

REM find most recent pak
set PAK=
for /F "usebackq delims=" %%I in (`dir /b /a-d /od *.pak`) do set PAK=%%~nI
set PAK_NAME=%PAK%.pak
set PAK_LIST=pak_list.txt

mkdir "%PAK%" > nul
copy "%PAK%.pak" "%PAK%\%PAK_NAME%"
%PSARC% list "%PAK%\%PAK_NAME%" > "%PAK%\%PAK_LIST%"

exit /b
