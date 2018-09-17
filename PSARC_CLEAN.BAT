@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set SRC="%~1"

REM use the name of the parent directory for the pak file
for %%I in (.) do set NAME=%%~nxI

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
set SEC=%CURRENT_TIME:~7,2%

set TIMESTAMP=%YYYY%%MM%%DD%.%HRS%.%MIN".%SEC%

REM append TIMESTAMP to pak_list
set PAK_LIST=%NAME%-%TIMESTAMP%-pak_list.tmp


REM -------------------------------------------------------------
REM EXECUTE

dir /b /s /a-d %SRC% > "%PAK_LIST%"

set /a COUNT=0
for /F "usebackq delims=" %%I in ("%PAK_LIST%") do (
    REM echo "%%~I"
    call :DELETE_FILE "%%~I"
)

del /q "%PAK_LIST%" > nul

echo(
echo %COUNT% files deleted.
echo(
pause
exit /b

REM -------------------------------------------------------------
REM FUNCTIONS
    
:DELETE_FILE
    REM echo FILE="%~1"
    REM echo EXT="%~x1"

    if "%~x1"==".DDS"      exit /b
    if "%~x1"==".MBIN"     exit /b
    if "%~x1"==".BIN"      exit /b
    if "%~x1"==".H"        exit /b
    if "%~x1"==".GLSL"     exit /b
    if "%~x1"==".PC"       exit /b
    if "%~x1"==".SQS"      exit /b
    if "%~x1"==".TXT"      exit /b
    if "%~x1"==".CSV"      exit /b
    if "%~x1"==".WEM"      exit /b
    if "%~x1"==".BNK"      exit /b
    if "%~x1"==".XML"      exit /b
    if "%~x1"==".TTC"      exit /b
    if "%~x1"==".TTF"      exit /b
    if "%~x1"==".FNT"      exit /b
    if "%~x1"==".JSON"     exit /b
    
    echo Deleting "%~1"
    set /a COUNT=%COUNT%+1
    del /q "%~1" > nul

    exit /b