#!/bin/bash

# Check our environment variables

if [ -z "$TIDDLYWIKI_RELEASE" ]; then
    export TIDDLYWIKI_RELEASE=$1
fi

if [  -z "$TIDDLYWIKI_RELEASE" ]; then
    export TIDDLYWIKI_RELEASE=2.7.0
fi

if [ -z "$TIDDLYWIKI_DEST" ]; then
    export TIDDLYWIKI_DEST=$PWD/cooked/$TIDDLYWIKI_RELEASE
fi

if [ -z "$TIDDLYWIKI_TEST" ]; then
    export TIDDLYWIKI_TEST=$PWD/test/index.html
fi

if [  -z "$TIDDLYWIKI5_DIR" ]; then
    export TIDDLYWIKI5_DIR=../../Jermolene/TiddlyWiki5
fi

if [  -z "$TW5_BUILD_OUTPUT" ]; then
    export TW5_BUILD_OUTPUT=../jermolene.github.com
fi

# Create directories

mkdir  -p $PWD/cooked
mkdir  -p $TIDDLYWIKI_DEST

# Build TiddlyWiki

node $TIDDLYWIKI5_DIR/tiddlywiki.js ./wiki --verbose --load ./index.html.recipe --savetiddler $:/core/templates/tiddlywiki2.template.html $TIDDLYWIKI_DEST/index.html text/plain

# Build tests

node $TIDDLYWIKI5_DIR/tiddlywiki.js ./wiki --verbose --load ../tiddlywiki/test/recipes/tests.html.recipe --savetiddler $:/core/templates/tiddlywiki2.template.html $TIDDLYWIKI_DEST/tests.html text/plain

# Open TiddlyWiki in PhantomJS to save index.html, empty.html and index.xml
phantomjs phantom_driver.js

# Still to do: zipping up empty.zip
