@echo off
setlocal
set VARNAME=%~1
set NAME=%~n2
set EXT=%~x2
set /a ID=%3

:NEXT_ID
    set TMP_NAME=%NAME%
    if not "%ID%"=="0" set TMP_NAME=%TMP_NAME%-%ID%
    if not EXIST "%TMP_NAME%%EXT%" goto FOUND_ID
    set /a ID=%ID%+1
    goto NEXT_ID
    :FOUND_ID

if not "%ID%"=="0" set NAME=%NAME%-%ID%

REM stdout
echo %NAME%

(endlocal & REM return values
    set %VARNAME%=%NAME%
)
exit /b