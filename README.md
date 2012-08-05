TiddlyWiki
==========

https://github.com/TiddlyWiki/tiddlywiki.com


Description
-----------

This repository contains the tools required to create the site http://tiddlywiki.com/

The content for tiddlywiki.com is obtained from a [TiddlySpace](http://tiddlyspace.com/).


Prerequisites
-------------

For the latest TiddlyWiki core source code, ensure that you have downloaded and installed the TiddlyWiki repository as described at https://github.com/TiddlyWiki/tiddlywiki

To build TiddlyWiki locally, ensure that you have downloaded and installed TiddlyWiki5 as described at https://github.com/jermolene/tiddlywiki5

To publish a new release of TiddlyWiki, ensure that you have downloaded and installed the TiddlyWiki "GitHub Pages" repository as described at https://github.com/TiddlyWiki/tiddlywiki.github.com

You need `nodejs` to build tiddlywiki.com. If you do not have it installed, it can be downloaded [here](http://www.nodejs.org)

You need `curl` to retrieve content from [TiddlySpace].  This is a standard command-line utility for Unix-based systems.  For Windows-based systems, it can be downloaded [here](http://curl.haxx.se/download.html)

You need a `diff` program to compare versions of TiddlyWiki (for testing after building).  This is a standard command-line utility for Unix-based systems.  For Windows-based systems, there are several applications to choose from.  Here are two alternatives:
[WinDiff](http://www.grigsoft.com/download-windiff.htm) and [ExamDiff](http://www.prestosoft.com/edp_examdiff.asp)

Building tiddlywiki.com
-----------------------

After downloading and installing TiddlyWiki checkout the version of TiddlyWiki that you wish to use for tiddlywiki.com. Ongoing development occurs in the tiddlywiki repository, so you need to checkout a tagged release version of TiddlyWiki. Change to the tiddlywiki directory and checkout the required version, eg:

    git checkout tags/v2.6.5

Change back to the tiddlywiki.com directory.

The tiddlywiki.com build process is divided into several parts: `setenv`, `pull`, `bld`, and `test`.  You can run each part separately, or invoke a complete build sequence by running `maketw`, which then automatically calls upon each separate part of the process.

Before building tiddlywiki.com, you must edit the `setenv` (or setenv.bat) script to set the correct release version number for TiddlyWiki.  Also, set the path for the TW5 repository (so that `boot.js` can be invoked), as well as the path locations of the `curl` and `diff` programs you have installed.  `setenv` is invoked automatically by each part of the build process, so that all build scripts share the same environment variables.

The `pull` (or pull.bat) script retrieves the tiddlywiki.com tiddler content from TiddlySpace and creates a sub-folder named 'pulled' containing .json files with the tiddler content

The `bld` (or bld.bat) script clears the target folder, `cooked/x.y.z` (where x.y.z is the new build release number) and then invokes TiddlyWiki5 (using nodejs) to generate a new target index.html file using `index.html.recipe` to incorporate the tiddler content from the .json files previously pulled from TiddlySpace.

Once this file is generated, the `bld` script then automatically opens the file in your browser, so that you can manually invoke the "save changes" command from within the newly created document.  Before saving, be sure you have set the TiddlyWiki options for "chkGenerateAnRssFeed" and "chkSaveEmptyTemplate" (see AdvancedOptions), so that saving the document also creates new versions of `empty.html` and `index.xml` (the TiddlyWiki RSS file) in the target folder.  Saving changes also causes TiddlyWiki to generate some static HTML within the `index.html` file for display when Javascript is not enabled.

The `bld` script is paused while you perform this manual "save changes" step.  After saving, you can close the browser window, and then return to the window in which the `bld` script is running so you can "press any key to continue" the process.  The script then assembles an `empty.zip` containing the newly generated `empty.html` as well as a copy of `TiddlySaver.jar` from the tiddlywiki repository.  This .zip file will be delivered to end-users when they use the 'download' button on tiddlywiki.com.

The `bld` script also copies the new index.html and empty.html files to a `test` folder (naming them `index.x.y.z.html` and `empty.x.y.z.html`, respectively) within the tiddlywiki.com repository so that TiddlyWiki developers can use these 'archived' copies for comparison with future builds.

After the `bld` script has assembled the new TiddlyWiki target files (.html, .xml, .jar, and .zip), `maketw` invokes the `test` (or test.bat) script, which performs a comparison between the newly generated index.html file and a copy of the previous version of TiddlyWiki that is stored in the tiddlywiki.com repository as `test/index.html`.  Note: whenever a new version of TiddlyWiki is officially published, the new index.html file must be updated and committed to the repository so that future builds will be tested against the most recent published version of TiddlyWiki.

Once the `bld` and `test` sequence has completed, you have successfully built a new local copy of TiddlyWiki.  You can then publish the results to http://tiddlywiki.com by copying the newly generated files (index.html, index.xml, TiddlySaver.jar, empty.html, and empty.zip) from the target folder (i.e., cooked/x.y.z/) into the local github.tiddlywiki.com repository and then commit those changes to the remote repository.  The committed files will automatically become available at http://tiddlywiki.github.com (which is also served by redirection from http://tiddlywiki.com)

Finally, to publish the new release for use with TiddlySpace, you need to manually upload the empty tiddlywiki file at cooked/x.y.z/empty.html to http://tiddlywiki-releases.tiddlyspace.com. This file needs to be uploaded to two places:

    http://tiddlywiki-releases.tiddlyspace.com/upgrade
    http://tiddlywiki-releases.tiddlyspace.com/x.y.z

You need to be a member of the tiddlywiki-releases.tiddlyspace.com space to do this.