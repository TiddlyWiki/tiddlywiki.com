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
echo BUILD: copying INDEX.HTML to TEST/INDEX.%TIDDLYWIKI_RELEASE%.HTML
copy %TIDDLYWIKI_DEST%\index.html %CD%\test\index.%TIDDLYWIKI_RELEASE%.html 1> NUL
echo BUILD: copying EMPTY.HTML to TEST/EMPTY.%TIDDLYWIKI_RELEASE%.HTML
copy %TIDDLYWIKI_DEST%\empty.html %CD%\test\empty.%TIDDLYWIKI_RELEASE%.html 1> NUL
echo - - - - - - - - - - - - - - -
echo BUILD: done
