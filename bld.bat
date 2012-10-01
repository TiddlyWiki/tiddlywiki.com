@ECHO OFF
call setenv %1

echo BUILD: clearing target folder: "cooked/%RELEASE%"
mkdir  cooked 2> NUL
mkdir  %DEST% 2> NUL & del /Q %DEST%
start /min %DEST%
echo - - - - - - - - - - - - - - -

echo BUILD: assembling INDEX.HTML (v%RELEASE%)
pushd tw2gen
node %TW5% --verbose --load ../index.html.recipe %TW5DEBUG% --savetiddler $:/core/templates/tiddlywiki2.template.html %DEST%/index.html text/plain
popd
echo - - - - - - - - - - - - - - -

echo BUILD: opening INDEX.HTML
echo BUILD: press "save changes" to generate EMPTY.HTML and INDEX.XML
pushd %DEST%
%BROWSER% index.html
popd
pause
echo - - - - - - - - - - - - - - -

echo BUILD: copying TIDDLYSAVER.JAR
copy ..\tiddlywiki\java\TiddlySaver.jar %DEST% 1> NUL
echo - - - - - - - - - - - - - - -

echo BUILD: generating EMPTY.ZIP
echo BUILD: copying files to temporary zip folder
mkdir %DEST%\zip 2> NUL & del /Q %DEST%\zip
copy  %DEST%\empty.html      %DEST%\zip 1> NUL
copy  %DEST%\tiddlysaver.jar %DEST%\zip 1> NUL

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
echo - - - - - - - - - - - - - - -

echo BUILD: copying INDEX.HTML to TEST/INDEX.%RELEASE%.HTML
copy %DEST%\index.html %CD%\test\index.%RELEASE%.html 1> NUL
echo BUILD: copying EMPTY.HTML to TEST/EMPTY.%RELEASE%.HTML
copy %DEST%\empty.html %CD%\test\empty.%RELEASE%.html 1> NUL

echo - - - - - - - - - - - - - - -
echo BUILD: done
