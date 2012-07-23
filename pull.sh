#!/bin/sh
# pulls down the "fat" JSON for each bag

echo PULL: clearing target folder: "pulled"
mkdir -p $pulled
rm -f $pulled/*

echo PULL: fetching tiddlers from remote TiddlySpaces:
echo PULL:    http://tiddlywiki-com.tiddlyspace.com
echo PULL:    http://tiddlywiki-com-ref.tiddyspace.com
echo PULL: exclude
echo PULL:    tag:systemConfig (except for plugins below)
echo PULL:    PageTemplate
echo PULL:    SiteSubtitle
echo PULL:    SiteTitle
echo PULL:    tiddlywiki-comSetupFlag
echo PULL:    tiddlywiki-com-refSetupFlag
echo PULL: include plugins
echo PULL:    DownloadTiddlyWikiPlugin
echo PULL:    SimpleSearchPlugin
echo PULL:    ExamplePlugin

curl -o $pulled/tiddlywiki-com-ref.tiddlers.json http://tiddlywiki-com-ref.tiddlyspace.com/bags/tiddlywiki-com-ref_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!SiteTitle;select=title:!SiteSubtitle;select=title:!tiddlywiki-com-refSetupFlag

curl -o $pulled/tiddlywiki-com.tiddlers.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!SiteTitle;select=title:!SiteSubtitle;select=title:!tiddlywiki-comSetupFlag

curl -o $pulled/DownloadTiddlyWikiPlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:DownloadTiddlyWikiPlugin

curl -o $pulled/SimpleSearchPlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:SimpleSearchPlugin

curl -o $pulled/ExamplePlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:ExamplePlugin

echo PULL: done