**Author: **_Gaticus Hax_


# BBCodeToMarkdown.bat

This batch script will convert the _(bbcode)_ used on NexusMods into markdown format.
This allows you to manage a single file for bb-formatted text on your mod page and
automatically generate a markdown file from it to include in your package for
plain-text viewing or display on [github](http://github.com), etc.

For example, the **README.md** file in this package is the same as the
**README.bbcode** file but processed with BBCodeToMarkdown script.

For advanced users; if using a build script for your mod project to
automate packaging new mod releases, you can include a call to the BBCodeToMarkdown
script before you zip everything.


## USE:
[i]This script is not specifically for README files but it's the typical use case.
Any specific references to README are just an example.[/i]

Write your **README.bbcode** file including the bbcodes used on NexusMods. You can use
whatever extension you like but _*.bbcode_ is conventional.

When you are ready to package a new release, just drag-n-drop the file onto
the **BBCodeToMarkdown.bat** script. The script will generate a file of the same name
but with a .md extension.

## Command Line Syntax
[code]BBCodeToMarkdown.bat <INPUT> [<OUTPUT>][/code]

**INPUT**:
The input path to a text file containing bbcode that will be converted to markdown.

**OUTPUT**:
The output path to a text file that will contain the converted markdown.

Optional. If no output parameter is specified, the path and name of the input file
will be used with the extension changed to ".md".


# Replace.vbs

_The BBCodeToMarkdown.bat script depends on the Replace.vbs script._

This is a command line script that does a search and replace on a target file using
regular expressions.


## Command Line Syntax
[code]Replace.vbs <TARGET> <SEARCH_PATTERN> <REPLACE_PATTERN>[/code]

Example: Convert bold bbcode to markdown
[code]Replace.vbs "path/to/file.txt" "\[b\](.*)\[/b\]" "**$1**"[/code]
If the file contains "**Bold Text**" it would be converted to"**Bold Text**".

**<TARGET>**:
Path to the text file to be processed.

**<SEARCH_PATTERN>**:
A regular expression that defines the search pattern and replacement groups.
Group delimiters are used in the search pattern to create tokens that can be used
in the replacement pattern.

In the covert bold bbcode to markdown example above, only the ".*" portion of the
search pattern, within the group delimiters '(' and ')' is preserved and corresponds
to the "$1" in the replacement pattern.

**<REPLACE_PATTERN>**:
A replacement pattern using regular expression group tokens. Groups are defined
in the search pattern and corresponding tokens can be used in the replacement pattern.

A group token is defined in the replacement pattern as "$n" (eg. "$1") where 'n' is a number
from 1 to the total number of groups in the search pattern. The value of a group token
depends on the order of the groups in the search pattern.

Example: Convert url bbcode to markdown

In the following example, 2 groups are defined in the search pattern. In the replacement
pattern, the groups are referenced as "$1" and "$2". Group 1 [i]("[^\x22\[\]]*")[/i] is the 
url address and group 2 [i](".*")[/i] is the link description.

[code]Replace.vbs "path/to/file.txt" "\[url \x22?([^\x22\[\]]*)\x22?\](.*)\[/url\]" "[$2]($1)"[/code]
If the file contains "[url http://domain.com]Description[/url]" it would be converted
to "[Description](http://domain.com)".