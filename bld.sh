#!/bin/bash

# Check our environment variables

if [ -z "$TIDDLYWIKI_RELEASE" ]; then
    export TIDDLYWIKI_RELEASE=$1
fi

if [  -z "$TIDDLYWIKI_RELEASE" ]; then
    export TIDDLYWIKI_RELEASE=2.7.0
fi

if [ -z "$TIDDLYWIKI_PULLED" ]; then
    export TIDDLYWIKI_PULLED=$PWD/pulled
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

mkdir  -p $TIDDLYWIKI_PULLED
mkdir  -p $PWD/cooked
mkdir  -p $TIDDLYWIKI_DEST

# Pull content from TiddlySpace

curl -o $TIDDLYWIKI_PULLED/tiddlywiki-com-ref.tiddlers.json "http://tiddlywiki-com-ref.tiddlyspace.com/bags/tiddlywiki-com-ref_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!tiddlywiki-com-refSetupFlag;select=title:!MarkupPreHead"

curl -o $TIDDLYWIKI_PULLED/tiddlywiki-com.tiddlers.json "http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!tiddlywiki-comSetupFlag;select=title:!MarkupPreHead"

curl -o $TIDDLYWIKI_PULLED/DownloadTiddlyWikiPlugin.json "http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:DownloadTiddlyWikiPlugin"

curl -o $TIDDLYWIKI_PULLED/SimpleSearchPlugin.json "http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:SimpleSearchPlugin"

curl -o $TIDDLYWIKI_PULLED/ExamplePlugin.json "http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:ExamplePlugin"


# Build TiddlyWiki

node $TIDDLYWIKI5_DIR/tiddlywiki.js $TIDDLYWIKI5_DIR/editions/tw2 --verbose --load ./index.html.recipe --savetiddler $:/core/templates/tiddlywiki2.template.html $TIDDLYWIKI_DEST/index.html text/plain

# Open TiddlyWiki in PhantomJS
phantomjs phantom_driver.js

# Still to do: zipping up empty.zip
