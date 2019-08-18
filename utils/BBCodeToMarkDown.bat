@echo off

set SCRIPT_PATH=%~dp0
set REPLACE_SCRIPT=%SCRIPT_PATH%replace.vbs

set SRC_FILE=%~1
set DST_FILE=%~2
if "%DST_FILE%"=="" set DST_FILE=%~dpn1.md

set REPLACE="%REPLACE_SCRIPT%" "%DST_FILE%"

copy /y "%SRC_FILE%" "%DST_FILE%" > nul

REM : convert [b]*[/b]
%REPLACE% "\[b\](.*)\[/b\]" "**$1**"

REM : convert [i]*[/i]
%REPLACE% "\[i\](.*)\[/i\]" "_$1_"

REM : convert [u]*[/u]
%REPLACE% "\[u\](.*)\[/u\]" "_**$1**_"

REM : convert [s]*[/s]
%REPLACE% "\[s\](.*)\[/s\]" "~~$1~~"

REM : convert [quote]*[/quote]
%REPLACE% "\[quote\](.*)\[/quote\]" "> $1"

REM : convert [img]*[/img]
%REPLACE% "\[img\](.*)\[/img\]" "![image]($1)"

REM : convert [youtube]*[/youtube]
%REPLACE% "\[youtube\](.*)\[/youtube\]" "[youtube](https://youtu.be/$1)"

REM : convert [url="$1"]$2[/url]
%REPLACE% "\[url=\x22?([^\x22\[\]]*)\x22?\](.*)\[/url\]" "[$2]($1)"

REM : strip [font="*"]*[/font]
%REPLACE% "\[font=[^\]]*\](.*)\[/font\]" "$1"

REM : convert [size="6"]*[/size] to # Heading
%REPLACE% "\[size=6\](.*)\[/size\]" "# $1"

REM : convert [size="5"]*[/size] to ## Heading
%REPLACE% "\[size=5\](.*)\[/size\]" "## $1"

REM : strip [size="4"]*[/size] to ### Heading
%REPLACE% "\[size=4\](.*)\[/size\]" "### $1"

REM : strip any other [size="*"]*[/size]
%REPLACE% "\[size=[^\]]*\](.*)\[/size\]" "$1"

REM : strip [color="*"]*[/color]
%REPLACE% "\[color=[^\]]*\](.*)\[/color\]" "$1"

REM : strip [left]*[/left]
%REPLACE% "\[left\](.*)\[/left\]" "$1"

REM : strip [center]*[/center]
%REPLACE% "\[center\](.*)\[/center\]" "$1"

REM : strip [right]*[/right]
%REPLACE% "\[right\](.*)\[/right\]" "$1"
