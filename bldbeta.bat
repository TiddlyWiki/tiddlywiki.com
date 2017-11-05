@ECHO OFF
call setenv %1
set TIDDLYWIKI_DEST=%CD%\cooked\%TIDDLYWIKI_RELEASE%\beta

echo BUILD: clearing target folder: "cooked/%TIDDLYWIKI_DEST%"
mkdir  cooked 2> NUL
mkdir  cooked/%TIDDLYWIKI_RELEASE% 2> NUL
mkdir  %TIDDLYWIKI_DEST% 2> NUL & del /Q %TIDDLYWIKI_DEST%
start /min %TIDDLYWIKI_DEST%
echo - - - - - - - - - - - - - - -
echo BUILD: creating INDEX.HTML (v%TIDDLYWIKI_RELEASE% beta)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js ./wiki --verbose --load ./beta.html.recipe --rendertiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/index.html text/plain
copy %TIDDLYWIKI_DEST%\index.html %TIDDLYWIKI_DEST%\TiddlyWiki.html  1> NUL
echo - - - - - - - - - - - - - - -
echo BUILD: creating TESTS.HTML (v%TIDDLYWIKI_RELEASE% beta)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js ./wiki --verbose --load ../tiddlywiki/test/recipes/tests.html.recipe --rendertiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/tests.html text/plain
echo - - - - - - - - - - - - - - -
echo BUILD: creating TIDDLYWIKI_EXTERNALJS.HTML (v%TIDDLYWIKI_RELEASE% beta)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js ./wiki --verbose --load ../tiddlywiki/tiddlywiki_externaljs.html.recipe --rendertiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/tiddlywiki_externaljs.html text/plain
echo - - - - - - - - - - - - - - -
echo BUILD: creating TIDDLYWIKI_EXTERNALJS_TIDDLYSPACE.HTML (v%TIDDLYWIKI_RELEASE% beta)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js ./wiki --verbose --load ../tiddlywiki/tiddlywiki_externaljs_tiddlyspace_beta.html.recipe --rendertiddler $:/core/templates/tiddlywiki2.template.html %TIDDLYWIKI_DEST%/tiddlywiki_externaljs_tiddlyspace.html text/plain
echo - - - - - - - - - - - - - - -
echo BUILD: creating TWCORE.JS (v%TIDDLYWIKI_RELEASE% beta)
node %TIDDLYWIKI5_DIR%/tiddlywiki.js ./wiki --verbose --load ../tiddlywiki/tiddlywikinosaver.html.recipe --rendertiddler $:/core/templates/tiddlywiki2.externaljs.template.html %TIDDLYWIKI_DEST%/twcore.js text/plain
echo - - - - - - - - - - - - - - -
REM
REM
REM
echo BUILD: *** TBD *** creating TIDDLYWIKI_COMPRESSED.HTML
REM cook $RECIPE -d $OUTPUT_DIR -o tiddlywiki_compressed.$RELEASE.html -cr -Cr -Dr
REM REPLACE cook ^^^ WITH nodejs TW5
REM
REM
REM
echo - - - - - - - - - - - - - - -
echo BUILD: copying TIDDLYSAVER.JAR
copy ..\tiddlywiki\java\TiddlySaver.jar %TIDDLYWIKI_DEST% 1> NUL
echo - - - - - - - - - - - - - - -
echo BUILD: copying JQUERY.JS
copy ..\tiddlywiki\jquery\jquery.js %TIDDLYWIKI_DEST% 1> NUL
echo - - - - - - - - - - - - - - -
echo BUILD: copying JQUERY.TWSTYLESHEET.JS
copy ..\tiddlywiki\jquery\plugins\jQuery.twStylesheet.js %TIDDLYWIKI_DEST% 1> NUL
echo - - - - - - - - - - - - - - -
echo BUILD: creating EMPTY.HTML and INDEX.XML from INDEX.HTML
set SAVE_RELEASE=%TIDDLYWIKI_RELEASE%
set TIDDLYWIKI_RELEASE=%TIDDLYWIKI_RELEASE%/beta
%BROWSER% phantom_driver.js
set TIDDLYWIKI_RELEASE=%SAVE_RELEASE%
echo - - - - - - - - - - - - - - -
echo BUILD: done
