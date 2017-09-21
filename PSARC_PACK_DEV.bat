@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set SRC=%~1

REM get the date stamp and split into components
set CURRENT_DATE=%date:~4%
set MM=%CURRENT_DATE:~0,2%
set DD=%CURRENT_DATE:~3,2%
set YYYY=%CURRENT_DATE:~6,4%

REM get the timestamp and split into components
set CURRENT_TIME=%time%
set HRS=%CURRENT_TIME:~0,2%
set HRS=%HRS: =0%
set MIN=%CURRENT_TIME:~3,2%

set TIMESTAMP=%YYYY%%MM%%DD%.%HRS%.%MIN%


REM -------------------------------------------------------------
REM EXECUTE

call "%~dp0\PSARC_PACK.bat" "%SRC%" "%TIMESTAMP%"

exit /b
