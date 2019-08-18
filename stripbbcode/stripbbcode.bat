@echo off

set SCRIPT_PATH=%~dp0
set REPLACE_SCRIPT=%SCRIPT_PATH%replace.vbs

set SRC_FILE=%~1
set DST_FILE=%~2
if "%DST_FILE%"=="" set DST_FILE=%~dpn1.md

set REPLACE="%REPLACE_SCRIPT%" "%DST_FILE%"

copy /y "%SRC_FILE%" "%DST_FILE%" > nul

REM : strip [b]*[/b]
%REPLACE% "\[b\]" ""
%REPLACE% "\[/b\]" ""

REM : strip [i]*[/i]
%REPLACE% "\[i\]" ""
%REPLACE% "\[/i\]" ""

REM : strip [u]*[/u]
%REPLACE% "\[u\]" ""
%REPLACE% "\[/u\]" ""

REM : convert [s]*[/s] to [strike]*[/strike]
%REPLACE% "\[s\]" "[strike]"
%REPLACE% "\[/s\]" "[/strike]"

REM ! leave quote tags ([quote]*[/quote])
REM %REPLACE% "\[quote\]" ""
REM %REPLACE% "\[/quote\]" ""

REM ! leave image tags ([img]*[/img])
REM %REPLACE% "\[img\]" ""
REM %REPLACE% "\[/img\]" ""

REM : convert [youtube]*[/youtube] to https://youtu.be/*
%REPLACE% "\[youtube\]" "https://youtu.be/"
%REPLACE% "\[/youtube\]" ""

REM : convert [url="$1"]$2[/url] to $2: $1
%REPLACE% "\[url=\x22?([^\x22\[\]]*)\x22?\](.*)\[/url\]" "$2: $1"

REM : strip [font="*"]*[/font]
%REPLACE% "\[font=[^\]]*\]" ""
%REPLACE% "\[/font\]" ""

REM : convert [size="6"]*[/size] to # Heading
%REPLACE% "\[size=6\]" "# "
%REPLACE% "\[/size\]" ""

REM : convert [size="5"]*[/size] to ## Heading
%REPLACE% "\[size=5\]" "## "
%REPLACE% "\[/size\]" ""

REM : strip [size="4"]*[/size] to ### Heading
%REPLACE% "\[size=4\]" "### "
%REPLACE% "\[/size\]" ""

REM : strip any other [size="*"]*[/size]
%REPLACE% "\[size=[^\]]*\]" ""
%REPLACE% "\[/size\]" ""

REM : strip [color="*"]*[/color]
%REPLACE% "\[color=[^\]]*\]" ""
%REPLACE% "\[/color\]" ""

REM : strip [left]*[/left]
%REPLACE% "\[left\]" ""
%REPLACE% "\[/left\]" ""

REM : strip [center]*[/center]
%REPLACE% "\[center\]" ""
%REPLACE% "\[/center\]" ""

REM : strip [right]*[/right]
%REPLACE% "\[right\]" ""
%REPLACE% "\[/right\]" ""
