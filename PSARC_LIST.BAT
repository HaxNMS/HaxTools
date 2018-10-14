@echo off 
setlocal enabledelayedexpansion

echo PSARC_LIST.BAT
echo by Gaticus Hax
echo] 
echo Drag-n-drop either a single pak file or a folder containing pak files onto
echo this script. A list of archived files for each pak will be dumped
echo to a pak_list.txt file in the same directory.
echo If a single pak file is specified, the pak_list.txt file will be prepended
echo with the name of the pak.


REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\bin\psarc.exe"

REM -------------------------------------------------------------
REM EXECUTE

if not exist "%~1" (
	echo "%~1" does not exist!
	goto ERROR
)

REM file or a directory?
:MODE_SELECTOR
	set attr=%~a1
	set dflag=%attr:~0,1%
	REM set rflag=%attr:~1,1%
	REM set aflag=%attr:~2,1%
	REM set hflag=%attr:~3,1%

	REM if dflag is 'd', srcTYPE will be FOLDER, otherwise it will be '-'
	set srcType=%dflag:d=FOLDER%
	REM if srcType is '-' it will be replaced with FILE
	set srcType=%srcType:-=FILE%

	goto LIST_%srcType%


:LIST_FILE
	pushd "%~dp1"
	set PAK=%~nx1
	set PAK_LIST=%~n1.pak_list.txt

	echo %PAK%
	%PSARC% list "%PAK%" > "%PAK_LIST%"

	echo Created "%PAK_LIST%"
	goto DONE

:LIST_FOLDER
	pushd "%~1"

	set PAK_LIST=pak_list.txt
	if exist "%PAK_LIST%" del /q "%PAK_LIST%"

	for %%I in ("*.pak") do (
	  echo %%~nxI
	  %PSARC% list "%%~nxI" >> "%PAK_LIST%
	  echo] >> "%PAK_LIST%"
	)

	if not exist "%PAK_LIST%" (
	  echo "%SRC%" does not contain any pak files.
	  goto ERROR
	)

	echo Created "%PAK_LIST%"
	goto DONE


:ERROR
	pause

:DONE
	popd

:EOF
	exit /b