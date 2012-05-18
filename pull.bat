@ECHO OFF

SET DEST=%CD%\pulled
if [%TW5%]==[] SET TW5=..\TiddlyWiki5\archive\tiddlywiki.js

echo PULL: clearing target folder (content)
mkdir %DEST% 2> NUL & del /Q %DEST%

echo PULL: fetching tiddlers from remote TiddlySpaces
echo * tiddlywiki-com.tiddlyspace.com AND tiddlywiki-com-ref.tiddyspace.com
echo * exclude tag:!systemConfig, PageTemplate, SiteSubtitle, SiteTitle
echo * include DownloadTiddlyWikiPlugin, SimpleSearchPlugin,
echo      ExamplePlugin, and SplashScreenPlugin
node %TW5% --recipe pull.recipe --savetiddlers %DEST%

echo PULL: done