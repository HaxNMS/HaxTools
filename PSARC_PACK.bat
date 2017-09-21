@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\bin\psarc.exe"
set SRC="%~1"

set SUFFIX=%~2
if not "%SUFFIX%"=="" set SUFFIX=-%SUFFIX%

REM use the name of the parent directory for the pak file
for %%I in (.) do set NAME=%%~nxI

REM append SUFFIX to NAME
set NAME=%NAME%%SUFFIX%

REM make sure the name is unique
set /a ID=0
if "%SUFFIX%"=="" set /a ID=1
:NEXT_ID
    set TMP_NAME=%NAME%
    if not "%ID%"=="0" set TMP_NAME=%TMP_NAME%-%ID%
    if not EXIST "%TMP_NAME%.pak" goto FOUND_ID
    set /a ID=%ID%+1
    goto NEXT_ID
    :FOUND_ID

if not "%ID%"=="0" set NAME=%NAME%-%ID%

set PAK_LIST=%NAME%-pak_list.txt

REM append VERSIONSTAMP and extension to NAME
set PAK_NAME=%NAME%.pak


REM -------------------------------------------------------------
REM EXECUTE

dir /b /s /a-d %SRC% > "%PAK_LIST%.tmp"
echo( > "%PAK_LIST%"
for /F "usebackq delims=" %%I in ("%PAK_LIST%.tmp") do (
    call :IMPORT_FILE "%%~I" >> "%PAK_LIST%"
)
del /q "%PAK_LIST%.tmp" > nul

%PSARC% create -y --strip=%SRC% --inputfile="%PAK_LIST%" --output="%PAK_NAME%"
%PSARC% verify "%PAK_NAME%"
del /q "%PAK_LIST%" > nul

pause
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