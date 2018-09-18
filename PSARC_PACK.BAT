@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\bin\psarc.exe"
set SRC=%~f1
if "%~nx1"=="GAMEDATA" set SRC=%~dp1
if "%SRC:~-1%"=="\" set SRC=%SRC:~0,-1%

set SUFFIX=%~2
if        "%SUFFIX:~0,1%"=="-" (
    REM do nothing
) else if "%SUFFIX:~0,1%"=="_" (
    REM do nothing
) else if "%SUFFIX:~0,1%"==" " (
    REM do nothing
) else if not "%SUFFIX%"=="" (
    set SUFFIX=-%SUFFIX%
)

set GAMEDATA=%SRC%\GAMEDATA
if not exist "%GAMEDATA%" set GAMEDATA=%SRC%

REM use the name of the parent directory for the pak file
for %%I in ( "%SRC%" ) do set NAME=%%~nxI

REM append SUFFIX to NAME
set NAME=%NAME%%SUFFIX%

REM make sure the name is unique
set /a ID=0
if not "%SUFFIX%"=="" (
    if not exist "%NAME%.pak" goto FOUND_ID
)

REM if there is no suffix or the name is not unique, then find
REM the most recent pak matching the name-version.pak pattern
:NEXT_ID
    set LATEST=
    for /F "usebackq delims=" %%I in (`dir /b /a-d /od "%NAME%-*.pak"`) do set LATEST=%%~nI
    set /a ID=%LATEST:!NAME!-=%
    set /a ID=%ID%+1

:FOUND_ID
    if not "%ID%"=="0" set NAME=%NAME%-%ID%

set PAK_LIST=%NAME%-pak_list.txt

REM append VERSIONSTAMP and extension to NAME
set PAK_NAME=%NAME%.pak


REM -------------------------------------------------------------
REM EXECUTE

dir /b /s /a-d "%GAMEDATA%" > "%PAK_LIST%.tmp"
echo( > "%PAK_LIST%"
for /F "usebackq delims=" %%I in ("%PAK_LIST%.tmp") do (
    call :IMPORT_FILE "%%~I" >> "%PAK_LIST%"
)
del /q "%PAK_LIST%.tmp" > nul

%PSARC% create -y --strip="%GAMEDATA%" --inputfile="%PAK_LIST%" --output="%PAK_NAME%"
%PSARC% verify "%PAK_NAME%"
del /q "%PAK_LIST%" > nul

exit /b

REM -------------------------------------------------------------
REM FUNCTIONS

:IMPORT_FILE
    if "%~x1"==".DDS"      goto DO_IMPORT
    if "%~x1"==".MBIN"     goto DO_IMPORT
    if "%~x1"==".BIN"      goto DO_IMPORT
    if "%~x1"==".H"        goto DO_IMPORT
    if "%~x1"==".GLSL"     goto DO_IMPORT
    if "%~x1"==".PC"       goto DO_IMPORT
    if "%~x1"==".SQS"      goto DO_IMPORT
    if "%~x1"==".TXT"      goto DO_IMPORT
    if "%~x1"==".CSV"      goto DO_IMPORT
    if "%~x1"==".WEM"      goto DO_IMPORT
    if "%~x1"==".BNK"      goto DO_IMPORT
    if "%~x1"==".XML"      goto DO_IMPORT
    if "%~x1"==".TTC"      goto DO_IMPORT
    if "%~x1"==".TTF"      goto DO_IMPORT
    if "%~x1"==".FNT"      goto DO_IMPORT
    if "%~x1"==".JSON"     goto DO_IMPORT

    REM not a valid asset type
    exit /b
    
    :DO_IMPORT
    echo %~1
    exit /b