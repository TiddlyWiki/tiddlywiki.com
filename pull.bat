@ECHO OFF
call setenv %1

echo PULL: clearing target folder: "pulled"
mkdir %TIDDLYWIKI_PULLED% 2> NUL & del /Q %TIDDLYWIKI_PULLED%

echo PULL: fetching tiddlers from remote TiddlySpaces:
echo PULL:    http://tiddlywiki-com.tiddlyspace.com
echo PULL:    http://tiddlywiki-com-ref.tiddyspace.com
echo PULL: exclude
echo PULL:    tag:systemConfig (except for plugins below)
echo PULL:    PageTemplate
echo PULL:    tiddlywiki-comSetupFlag
echo PULL:    tiddlywiki-com-refSetupFlag
echo PULL: include plugins
echo PULL:    DownloadTiddlyWikiPlugin
echo PULL:    SimpleSearchPlugin
echo PULL:    ExamplePlugin

%CURL% -o %TIDDLYWIKI_PULLED%/tiddlywiki-com-ref.tiddlers.json http://tiddlywiki-com-ref.tiddlyspace.com/bags/tiddlywiki-com-ref_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!tiddlywiki-com-refSetupFlag 2> NUL

%CURL% -o %TIDDLYWIKI_PULLED%/tiddlywiki-com.tiddlers.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=tag:!systemConfig;select=title:!PageTemplate;select=title:!tiddlywiki-comSetupFlag 2> NUL

%CURL% -o %TIDDLYWIKI_PULLED%/DownloadTiddlyWikiPlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:DownloadTiddlyWikiPlugin 2> NUL

%CURL% -o %TIDDLYWIKI_PULLED%/SimpleSearchPlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:SimpleSearchPlugin 2> NUL

%CURL% -o %TIDDLYWIKI_PULLED%/ExamplePlugin.json http://tiddlywiki-com.tiddlyspace.com/bags/tiddlywiki-com_public/tiddlers.json?fat=1;select=title:ExamplePlugin 2> NUL

echo PULL: done
