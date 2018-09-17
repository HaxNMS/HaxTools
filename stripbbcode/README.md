[size=6][color=##FF0000]StripBBcodes[/color][/size]
[size=3][color=#FFFF00][i]Created by Gaticus Hax[/i][/color][/size]

This batch file will strip the markdown [i](bbcode)[/i] used on NexusMods from
a specified file so you can have a single file for bb-formatted text on your
mod page and for a plain-text readme file to include in your package.

I made this for a project I was working on, so that I only needed to update the
project's readme in a single file instead of two. For example, the [b]README.txt[/b]
file in this package is the same as the [b]README.md[/b] file but processed with
the script.

There is an option in the NexusMods online editor to strip the bbcodes as well,
but it is not convenient except for 'one-off' tasks. If you update your mod/tool
and README frequently, then using this method is much easier.

For more tech-savvy modders, if using a build script for your mod project to
automate packaging new mod releases, you can include a call to the strippbbcodes
script before you zip everything.


[size=5][color=##FF0000]INSTALL:[/color][/size]
Unzip wherever you want.


[size=5][color=##FF0000]USE:[/color][/size]
There are two files in this package but you only need to concern yourself with
the [b]stripbbcodes.bat[/b] file. The other [b]replace.vbs[/b] file is a helper
used by the bat file.

This script is not specifically for README files but that's pretty much all I've
ever used it for, so the specific references to README are just for simplicity.

Write your [b]README.md[/b] file including the bbcodes used on NexusMods. You can use
whatever extension you like but [i]*.md[/i] is the convention for markdown files.
This file will be the one you make all your edits to. Don't use .txt as the script
will generate a file with the same name but a txt extension.

When you are ready to package a new release, just drag-n-drop the file onto
the [b]stripbbcodes.bat[/b] file and a *.txt file will be generated with the same name.


[size=5][color=##FF0000]NOTES:[/color][/size]
To preserve the intent of the bbcode formatting, not all codes are stripped and
some are converted to a more human friendly notation.

A few of the size codes are handled specially and assumed to be headings.
Size 6,5 and 4 will be converted to have #, ## and ### prepended respectively.

If other people actually use this script, I may make improvements at request to
better handle the conversion of some codes, such as for headings or to convert
from bbcode to a more standard markdown format instead of just basic
stripping/conversion.