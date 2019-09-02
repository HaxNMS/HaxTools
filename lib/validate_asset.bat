@echo off
REM returns ERRORLEVEL 0 if passed
REM returns ERRORLEVEL 1 if failed

set VALID_TYPES=DDS MBIN BIN H GLSL SPV PC SQS TXT CSV WEM BNK XML TTC TTF FNT JSON
for %%I in (%VALID_TYPES%) do if /i "%~x1"==".%%I" exit /b 0
REM invalid asset type
exit /b 1

REM if /i "%~x1"==".DDS"      exit /b 0
REM if /i "%~x1"==".MBIN"     exit /b 0
REM if /i "%~x1"==".BIN"      exit /b 0
REM if /i "%~x1"==".H"        exit /b 0
REM if /i "%~x1"==".GLSL"     exit /b 0
REM if /i "%~x1"==".PC"       exit /b 0
REM if /i "%~x1"==".SQS"      exit /b 0
REM if /i "%~x1"==".TXT"      exit /b 0
REM if /i "%~x1"==".CSV"      exit /b 0
REM if /i "%~x1"==".WEM"      exit /b 0
REM if /i "%~x1"==".BNK"      exit /b 0
REM if /i "%~x1"==".XML"      exit /b 0
REM if /i "%~x1"==".TTC"      exit /b 0
REM if /i "%~x1"==".TTF"      exit /b 0
REM if /i "%~x1"==".FNT"      exit /b 0
REM if /i "%~x1"==".JSON"     exit /b 0

REM REM not a valid asset type
REM exit /b 1
