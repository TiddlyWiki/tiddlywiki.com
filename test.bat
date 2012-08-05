@ECHO OFF
call setenv %1 %2

:diff
echo TEST: running version comparison...
echo TEST: new=%DEST%\index.html
echo TEST: old=%TEST%
%DIFF% "%DEST%\index.html" "%TEST%"

echo TEST: done
