@echo off 
setlocal EnableDelayedExpansion

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
if not exist "%NAME%.pak" goto FOUND_ID

REM if there is no suffix or the name is not unique, then find
REM the most recent pak matching the name-version.pak pattern
:NEXT_ID
    set /a ID=%ID% + 1
    for /F "usebackq delims=" %%I in (`dir /b /a-d /od "%NAME%*.pak"`) do set LATEST=%%~nI
    set LATEST=!LATEST:%NAME%=!
           if "%LATEST:~0,1%"=="-" ( set LATEST=%LATEST:~1%
    ) else if "%LATEST:~0,1%"=="_" ( set LATEST=%LATEST:~1%
    ) else if "%LATEST:~0,1%"==" " ( set LATEST=%LATEST:~1% )
    if not "%LATEST%"=="" set /a ID=%LATEST% + 1

:FOUND_ID
    if not "%ID%"=="0" set NAME=%NAME%-%ID%

set PAK_LIST=%NAME%-pak_list.txt

REM append extension to NAME
set PAK=%NAME%.pak

REM -------------------------------------------------------------
REM EXECUTE

REM generate the import list for psarc
dir /b /s /a-d "%GAMEDATA%" > "%PAK_LIST%.tmp"
echo( > "%PAK_LIST%"
for /F "usebackq delims=" %%I in ("%PAK_LIST%.tmp") do (
    call :IMPORT_FILE "%%~I" >> "%PAK_LIST%"
)
del /q "%PAK_LIST%.tmp" > nul

%PSARC% create -y --ignorecase --strip="%GAMEDATA%" --inputfile="%PAK_LIST%" --output="%PAK%"
%PSARC% verify "%PAK%"
del /q "%PAK_LIST%" > nul

goto END

REM -------------------------------------------------------------
REM FUNCTIONS

:IMPORT_FILE
    call "%~dp0\lib\validate_asset.bat" %1
    if %ERRORLEVEL%==1 exit /b
    echo]%~1
    exit /b
    
:END
    endlocal && set NAME=%NAME%
    exit /b
