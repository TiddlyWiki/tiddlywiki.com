#!/bin/sh
#
# *** LOCAL TARGET PATHS and FILES
DEFAULT_RELEASE="2.6.6a"
RELEASE=${1:-$DEFAULT_RELEASE}
PULLED=$PWD\pulled
DEST=$PWD\cooked\$RELEASE
TEST=$PWD\test\index.html
TW5=..\..\..\jermolene\tiddlywiki5\core\boot.js
