@echo off
REM returns ERRORLEVEL 0 if passed
REM returns ERRORLEVEL 1 if failed

if "%~x1"==".DDS"      exit /b 0
if "%~x1"==".MBIN"     exit /b 0
if "%~x1"==".BIN"      exit /b 0
if "%~x1"==".H"        exit /b 0
if "%~x1"==".GLSL"     exit /b 0
if "%~x1"==".PC"       exit /b 0
if "%~x1"==".SQS"      exit /b 0
if "%~x1"==".TXT"      exit /b 0
if "%~x1"==".CSV"      exit /b 0
if "%~x1"==".WEM"      exit /b 0
if "%~x1"==".BNK"      exit /b 0
if "%~x1"==".XML"      exit /b 0
if "%~x1"==".TTC"      exit /b 0
if "%~x1"==".TTF"      exit /b 0
if "%~x1"==".FNT"      exit /b 0
if "%~x1"==".JSON"     exit /b 0

REM not a valid asset type
exit /b 1
