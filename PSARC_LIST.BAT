@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\bin\psarc.exe"
set PAK=%~nx1
set PAK_LIST=%~n1%-pak_list.txt

REM -------------------------------------------------------------
REM EXECUTE

del /q "%PAK_LIST%" > nul
%PSARC% list "%PAK%" > "%PAK_LIST%"

exit /b
