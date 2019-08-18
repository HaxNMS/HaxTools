Const READ  = 1
Const WRITE = 2

sFileName = Wscript.Arguments(0)
sPattern = Wscript.Arguments(1)
sReplace = Wscript.Arguments(2)

Set oFSO = CreateObject("Scripting.FileSystemObject")
Set oFile = oFSO.OpenTextFile(sFileName,READ)
sText = oFile.ReadAll
oFile.Close

Set regEx = New RegExp
regEx.Global = True
regEx.Multiline = True
regEx.Pattern = sPattern
sText = regEx.Replace(sText,sReplace)

Set oFile = oFSO.OpenTextFile(sFileName,WRITE)
oFile.Write sText
oFile.Close
