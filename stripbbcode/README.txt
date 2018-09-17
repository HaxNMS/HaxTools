# StripBBcodes
Created by Gaticus Hax

This batch file will strip the markdown (bbcode) used on NexusMods from
a specified file so you can have a single file for bb-formatted text on your
mod page and for a plain-text readme file to include in your package.

I made this for a project I was working on, so that I only needed to update the
project's readme in a single file instead of two. For example, the README.txt
file in this package is the same as the README.md file but processed with
the script.

There is an option in the NexusMods online editor to strip the bbcodes as well,
but it is not convenient except for 'one-off' tasks. If you update your mod/tool
and README frequently, then using this method is much easier.

For more tech-savvy modders, if using a build script for your mod project to
automate packaging new mod releases, you can include a call to the strippbbcodes
script before you zip everything.


## INSTALL:
Unzip wherever you want.


## USE:
There are two files in this package but you only need to concern yourself with
the stripbbcodes.bat file. The other replace.vbs file is a helper
used by the bat file.

This script is not specifically for README files but that's pretty much all I've
ever used it for, so the specific references to README are just for simplicity.

Write your README.md file including the bbcodes used on NexusMods. You can use
whatever extension you like but *.md is the convention for markdown files.
This file will be the one you make all your edits to. Don't use .txt as the script
will generate a file with the same but but a txt extension.

When you are ready to package a new release, just drag-n-drop the file onto
the stripbbcodes.bat file and a *.txt file will be generated with the same name.


## NOTES:
To preserve the intent of the bbcode formatting, not all codes are stripped and
some are converted to a more human friendly notation.

A few of the size codes are handled specially and assumed to be headings.
Size 6,5 and 4 will be converted to have #, ## and ### prepended respectively.

If other people actually use this script, I may make improvements at request to
better handle the conversion of some codes, such as for headings or to convert
from bbcode to a more standard markdown format instead of just basic
stripping/conversion.