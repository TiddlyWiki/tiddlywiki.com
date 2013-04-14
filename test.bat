@ECHO OFF
call setenv %1 %2

:diff
echo TEST: running version comparison...
echo TEST: new=%TIDDLYWIKI_DEST%\index.html
echo TEST: old=%TIDDLYWIKI_TEST%
%DIFF% "%TIDDLYWIKI_DEST%\index.html" "%TIDDLYWIKI_TEST%"

echo TEST: done
