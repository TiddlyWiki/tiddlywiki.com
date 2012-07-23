#!/bin/sh

./setenv ${1} ${2}

echo TEST: running version comparison...
echo TEST: new=$DEST\index.html
echo TEST: old=$TEST
diff "$DEST\index.html" "$TEST"

echo TEST: done
