@ECHO OFF

SET RELEASE=%1
IF [%1]==[] goto usage
SET DEST=%CD%\cooked\%RELEASE%
if [%TW5%]==[] SET TW5=..\TiddlyWiki5\archive\tiddlywiki.js

echo BUILD: clearing target folder (cooked/%RELEASE%)
mkdir  cooked 2> NUL
mkdir  %DEST% 2> NUL & del /Q %DEST%

echo BUILD: assembling EMPTY.HTML
node %TW5% --recipe empty.html.recipe --savewiki %DEST%
ren %DEST%\index.html empty.html

echo BUILD: assembling INDEX.HTML
node %TW5% --recipe index.html.recipe --savewiki %DEST%

echo BUILD: copying TIDDLYSAVER.JAR
copy ..\tiddlywiki\java\TiddlySaver.jar %DEST% 1> NUL

echo BUILD: copying files to temporary zip folder
mkdir  %DEST%\zip 2> NUL & del /Q %DEST%\zip
copy %DEST%\empty.html      %DEST%\zip 1> NUL
copy %DEST%\tiddlysaver.jar %DEST%\zip 1> NUL

echo BUILD: generating EMPTY.ZIP
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
CScript _zipIt.vbs %DEST%\zip %DEST%\empty.zip 1> NUL

echo BUILD: cleaning up temporary files/folder
del _zipIt.vbs & del /Q %DEST%\zip & rmdir %DEST%\zip

echo BUILD: done
goto:eof

:usage
echo USAGE: %0 {target release #}