@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\psarc.exe"

REM -------------------------------------------------------------
REM EXECUTE

set SRC=%~1
set DST=%SRC%
if [%~n1]==[GAMEDATA] set SRC=%SRC%\PCBANKS
if [%~n1]==[PCBANKS]  set DST=.\

set XML="%SRC%\PSARC_Extract.xml"

echo]^<psarc^> > %XML%

for /F %%I in ('dir /b "%SRC%\*.pak"') do echo]    ^<extract archive^=^"%SRC%\%%~I^" to^=^"%DST%^" /^> >> %XML%

echo]^</psarc^> >> %XML%

%PSARC% --xml=%XML%

exit /b
