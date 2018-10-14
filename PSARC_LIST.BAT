@echo]************************************************************
@echo]*  
@echo]*  %~nx0
@echo]*  
@echo]*  Drag-n-drop one or more pak files or folders containing pak files onto
@echo]*  this script. A list of archived files for each pak will be dumped
@echo]*  to a pak_list.txt file in the same directory.
@echo]* 
@echo]************************************************************
@echo]  
@echo off
setlocal

REM -------------------------------------------------------------
REM INITIALIZE

set PSARC="%~dp0\bin\psarc.exe"

REM -------------------------------------------------------------
REM EXECUTE

REM NOTHING TO DO?
if "%~1"=="" goto EOF

REM MAIN LOOP
:NEXT
    if "%~1"=="" goto EOF
    call :VALIDATE_PATH_EXISTS %1 || goto EOF
    call :DETECT_FOLDER %1 && call :LIST_FOLDER %1 || call :LIST_FILE %1
    shift & goto NEXT

SANITY CHECK: This should never be reached!
    
REM -------------------------------------------------------------
REM FUNCTIONS

REM returns 0 (success) or 1 (fail)
:VALIDATE_PATH_EXISTS
    if not exist %1 call :ERROR %1 does not exist! & exit /b 1
    exit /b 0

REM Detects if %1 is a directory or a file.
REM returns 0 (folder) or 1 (file)
:DETECT_FOLDER
    setlocal
	set attr=%~a1
	set attr=%attr:~0,1%
    set attr=%attr:-=%
    if not defined attr exit /b 1
    exit /b 0

:LIST_FILE
	pushd "%~dp1"
	set PAK=%~nx1
	set PAK_LIST=%~n1.pak_list.txt

	echo %PAK%
	%PSARC% list "%PAK%" > "%PAK_LIST%"

	echo Created "%PAK_LIST%" & goto DONE

:LIST_FOLDER
	pushd "%~1"

	set PAK_LIST=../%~n1.pak_list.txt
	if exist "%PAK_LIST%" del /q "%PAK_LIST%"

	for %%I in ("*.pak") do (
	  echo %%~nxI
	  %PSARC% list "%%~nxI" >> "%PAK_LIST%
	  echo] >> "%PAK_LIST%"
	)

	if not exist "%PAK_LIST%" (
	  call :ERROR "%SRC%" does not contain any pak files. & goto DONE
	)

	echo Created "%PAK_LIST%"
    goto DONE
        
:ERROR
    echo %* & echo] & pause & exit /b

:DONE
    popd & exit /b

:EOF
