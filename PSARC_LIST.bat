@echo off 
setlocal
set SCRIPT_PATH=%~dp0
set SCRIPT_PATH=%SCRIPT_PATH:~0,-1%

set PSARC="%SCRIPT_PATH%\bin\psarc.exe"

REM -------------------------------------------------------------
REM INITIALIZE

set PAK=%~nx1
set PAK_LIST=%~n1%-pak_list.txt

REM -------------------------------------------------------------
REM EXECUTE

del /q "%PAK_LIST%" > nul
%PSARC% list "%PAK%" > "%PAK_LIST%"

exit /b
