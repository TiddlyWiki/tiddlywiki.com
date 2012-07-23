#!/usr/bin/env bash

# Usage:
#  bld [release]

./setenv ${1}

echo BUILD: clearing target folder: "cooked/$RELEASE"
mkdir -p cooked
mkdir $DEST
rm -f $DEST/*
echo - - - - - - - - - - - - - - -

echo BUILD: assembling INDEX.HTML (v$RELEASE)
pushd tw2gen
node $TW5 --verbose --load ../index.html.recipe $TW5DEBUG --savetiddler $:/core/templates/tiddlywiki2.template.html $DEST/index.html text/plain
popd
echo - - - - - - - - - - - - - - -

echo BUILD: opening INDEX.HTML
echo BUILD: press "save changes" to generate EMPTY.HTML and INDEX.XML
pushd $DEST
./index.html
popd
pause
echo - - - - - - - - - - - - - - -

echo BUILD: copying TIDDLYSAVER.JAR
copy ..\tiddlywiki\java\TiddlySaver.jar $DEST
echo - - - - - - - - - - - - - - -

echo BUILD: generating EMPTY.ZIP
echo BUILD: copying files to temporary zip folder
rm $DEST/empty.zip
mkdir $DEST\zip
rm -f $DEST\zip\*
copy  $DEST\empty.html      $DEST\zip
copy  $DEST\tiddlysaver.jar $DEST\zip
zip -j $DEST/empty.zip $DEST/zip/empty.html $DEST/zip/TiddlySaver.jar

echo BUILD: cleaning up temporary files/folder
rm -f $DEST/zip/*
rmdir $DEST/zip
echo - - - - - - - - - - - - - - -

echo BUILD: copying INDEX.HTML to TEST/INDEX.$RELEASE.HTML
copy $DEST\index.html $PWD\test\index.$RELEASE.html 1> NUL
echo BUILD: copying EMPTY.HTML to TEST/EMPTY.$RELEASE.HTML
copy $DEST\empty.html $PWD\test\empty.$RELEASE.html 1> NUL

echo - - - - - - - - - - - - - - -
echo BUILD: done
