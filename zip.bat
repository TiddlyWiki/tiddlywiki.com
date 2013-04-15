@ECHO OFF
call setenv %1

echo BUILD: generating EMPTY.ZIP
echo BUILD: copying files to temporary zip folder
mkdir %TIDDLYWIKI_DEST%\zip 2> NUL & del /Q %TIDDLYWIKI_DEST%\zip
copy  %TIDDLYWIKI_DEST%\empty.html      %TIDDLYWIKI_DEST%\zip 1> NUL
copy  %TIDDLYWIKI_DEST%\tiddlysaver.jar %TIDDLYWIKI_DEST%\zip 1> NUL

rem *** NOTE: create and invoke a temporary script, _zipIt.vbs, that generates a ZIP file:
rem *** http://superuser.com/questions/110991/can-you-zip-a-file-from-the-command-prompt-using-only-windows-built-in-capabili/112094#112094
 > _zipIt.vbs echo Set objArgs = WScript.Arguments
>> _zipIt.vbs echo InputFolder = objArgs(0)
>> _zipIt.vbs echo ZipFile = objArgs(1)
>> _zipIt.vbs echo CreateObject("Scripting.FileSystemObject").CreateTextFile(ZipFile, True).Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar)
>> _zipIt.vbs echo Set objShell = CreateObject("Shell.Application")
>> _zipIt.vbs echo Set source = objShell.NameSpace(InputFolder).Items
>> _zipIt.vbs echo objShell.NameSpace(ZipFile).CopyHere(source)
>> _zipIt.vbs echo wScript.Sleep 2000 
CScript _zipIt.vbs %TIDDLYWIKI_DEST%\zip %TIDDLYWIKI_DEST%\empty.zip 1> NUL

echo BUILD: cleaning up temporary files/folder
del _zipIt.vbs & del /Q %TIDDLYWIKI_DEST%\zip & rmdir %TIDDLYWIKI_DEST%\zip
