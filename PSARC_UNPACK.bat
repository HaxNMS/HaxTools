@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\psarc.exe"

set SRC="%~1"
set NAME=%~n1

REM -------------------------------------------------------------
REM EXECUTE

mkdir "%NAME%"
%PSARC% extract --to="%NAME%" %SRC%

exit /b
