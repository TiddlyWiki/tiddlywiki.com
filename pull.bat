@ECHO OFF
call setenv %1

echo PULL: clearing target folder: "pulled"
mkdir %PULLED% 2> NUL & del /Q %PULLED%

echo PULL: fetching tiddlers from remote TiddlySpaces:
echo PULL:    http://tiddlywiki-com.tiddlyspace.com
echo PULL:    http://tiddlywiki-com-ref.tiddyspace.com
echo PULL: exclude
echo PULL:    tag:systemConfig
echo PULL:    PageTemplate
echo PULL:    SiteSubtitle
echo PULL:    SiteTitle
echo PULL: include
echo PULL:    DownloadTiddlyWikiPlugin
echo PULL:    SimpleSearchPlugin
echo PULL:    ExamplePlugin
echo PULL:    SplashScreenPlugin

node %TW5% --recipe pull.recipe --savetiddlers %PULLED%

echo PULL: done