REM PSARC_LIST_PAKS.BAT
REM by Gaticus Hax
REM
REM Drag-n-drop either the GAMEDATA or the PCBANKS onto the BAT file.
REM A list of archived files for each pak in the PCBANKS folder will 
REM be dumped to a pak_list.txt file in the same directory.

@echo off 
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\psarc.exe"

REM -------------------------------------------------------------
REM EXECUTE

set SRC=%~1
if [%~n1]==[GAMEDATA] set SRC=%SRC%\PCBANKS

pushd "%SRC%"

set PAK_LIST=%SRC%\pak_list.txt
if exist "%PAK_LIST%" del /q "%PAK_LIST%"

for %%I in ("*.pak") do (
  echo] %%~nxI
  %PSARC% list "%%~nxI" >> "%PAK_LIST%
  echo] >> "%PAK_LIST%"
)

if not exist "%PAK_LIST%" (
  echo] "%SRC%" does not contain any pak files.
  goto DONE
)

echo] Created "%PAK_LIST%"

:DONE
popd
pause
exit /b
