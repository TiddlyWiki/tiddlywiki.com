@ECHO OFF
call setenv %1

echo BUILD: clearing target folder: "cooked/%TIDDLYWIKI_RELEASE%"
mkdir  cooked 2> NUL
mkdir  %TIDDLYWIKI_DEST% 2> NUL & del /Q %TIDDLYWIKI_DEST%
start /min %TIDDLYWIKI_DEST%
echo - - - - - - - - - - - - - - -

echo BUILD: assembling INDEX.HTML (v%TIDDLYWIKI_RELEASE%)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js %TIDDLYWIKI5_DIR%/editions/tw2 --verbose --load ./index.html.recipe --savetiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/index.html text/plain
echo - - - - - - - - - - - - - - -

echo BUILD: assembling TESTS.HTML (v%TIDDLYWIKI_RELEASE%)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js %TIDDLYWIKI5_DIR%/editions/tw2 --verbose --load ../tiddlywiki/test/recipes/tests.html.recipe --savetiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/tests.html text/plain
echo - - - - - - - - - - - - - - -

echo BUILD: creating EMPTY.HTML and INDEX.XML from INDEX.HTML
%BROWSER% phantom_driver.js
echo - - - - - - - - - - - - - - -

echo BUILD: copying TIDDLYSAVER.JAR
copy ..\tiddlywiki\java\TiddlySaver.jar %TIDDLYWIKI_DEST% 1> NUL
echo - - - - - - - - - - - - - - -

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
echo - - - - - - - - - - - - - - -

echo BUILD: copying INDEX.HTML to TEST/INDEX.%TIDDLYWIKI_RELEASE%.HTML
copy %TIDDLYWIKI_DEST%\index.html %CD%\test\index.%TIDDLYWIKI_RELEASE%.html 1> NUL
echo BUILD: copying EMPTY.HTML to TEST/EMPTY.%TIDDLYWIKI_RELEASE%.HTML
copy %TIDDLYWIKI_DEST%\empty.html %CD%\test\empty.%TIDDLYWIKI_RELEASE%.html 1> NUL

echo - - - - - - - - - - - - - - -
echo BUILD: done
