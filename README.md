TiddlyWiki
==========

https://github.com/TiddlyWiki/tiddlywiki.com


Description
-----------

This repository contains the tools required to create the site http://tiddlywiki.com/

The content for tiddlywiki.com is obtained from a [TiddlySpace](http://tiddlyspace.com/).


Prerequisites
-------------

You need perl to build tiddlywiki.com. If you do not have it installed, it can be downloaded [here](http://www.perl.org/get.html).

You need to set up `ginsu`. Copy the `ginsu` script file to somewhere that is on your path. Edit this file according to the instructions in the file.


Building tiddlywiki.com
-----------------------

First ensure that you have downloaded and installed TiddlyWiki as described at https://github.com/TiddlyWiki/tiddlywiki

Pull down the tiddlywiki.com content form TiddlySpace by invoking the `pull.sh` script:

    ./pull.sh

Edit the build script `bld` setting the correct version number for TiddlyWiki.

Invoke the build script:

    ./bld

You now need to generate the TiddlyWiki RSS file. To do this open the TiddlyWiki file index.html in Firefox, ensure the AdvancedOption "Generate an RSS feed when saving changes" is set, and then save the TiddlyWiki. Doing this also causes TiddlyWiki to generate some static HTML for display when Javascript is not enabled.

Finally upload the TiddlyWiki files to tiddlywiki.com:

    ./upload

You will be prompted for your password on several occasions during the upload process. To do this you will of course need an account on tiddlywiki.com. The upload script assumes your remote user name is the same as your local user name, if it is not then you may specify your remote user name as the second parameter to the upload script (the first parameter is the TiddlyWiki version number).

Migrated from http://svn.tiddlywiki.org on 20110719.
