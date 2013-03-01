TiddlyWiki
==========

https://github.com/TiddlyWiki/tiddlywiki.com


Description
-----------

This repository contains the tools required to create the site http://tiddlywiki.com/.

The content for tiddlywiki.com is obtained from a [TiddlySpace](http://tiddlyspace.com/).


Prerequisites
-------------

The following steps prepare your machine for building tiddlywiki.com:

1. Install the latest version of `nodejs` from http://www.nodejs.org
2. If necessary, install the command line tool `curl` to retrieve content from TiddlySpace. For Windows systems, it can be downloaded from http://curl.haxx.se/download.html
3. If necessary, install a `diff` program to compare versions of TiddlyWiki for testing after building. Mac OS X users can use `opendiff` that ships with XCode. Two options for Windows users are [WinDiff](http://www.grigsoft.com/download-windiff.htm) and [ExamDiff](http://www.prestosoft.com/edp_examdiff.asp)
4. Checkout or download the following repositories from GitHub:
	5. https://github.com/TiddlyWiki/TiddlyWiki for the TiddlyWiki core source code. You can either download the latest version or visit https://github.com/TiddlyWiki/tiddlywiki/tags to download a specific tagged version
	6. https://github.com/Jermolene/TiddlyWiki5 for TiddlyWiki5
	7. https://github.com/TiddlyWiki/tiddlywiki.github.com for the TiddlyWiki GitHub Pages (only required if you are actually publishing the build to tiddlywiki.com)

The recommended directory structure for downloading the repositories is as follows:

	+--- MyTiddlyWikiBuildDir
			|
			+--- TiddlyWiki
			|		|
			|		+--- TiddlyWiki
			|		|
			|		+--- tiddlywiki.github.com
			|
			+--- Jermolene
					|
					+--- TiddlyWiki5

Overview
--------

The tiddlywiki.com build process is divided into several parts: `setenv`, `pull`, `bld`, and `test`.  You can run each part separately, or invoke a complete build sequence by running `maketw`, which then automatically calls upon each separate part of the process.


Building tiddlywiki.com
-----------------------

These steps should be performed with the current directory set to the tiddlywiki.com repository.

## Setting up batch files

Edit the `setenv.bat/sh` script to set:

* the correct release version number for TiddlyWiki
* the path for the TW5 repository
* the path locations of the `curl` and `diff` programs you have installed
* the location of a web browser

`setenv` is invoked automatically by each part of the build process, so that all build scripts share the same environment variables.

## Pulling content from TiddlySpace

The `pull.bat/sh` script retrieves the tiddlywiki.com tiddler content from TiddlySpace and creates a sub-folder named 'pulled' containing `.json` files with the tiddler content.

## Cooking TiddlyWiki

The `bld.bat/sh` script clears the target folder, `cooked/x.y.z` (where x.y.z is the new build release number) and then invokes TiddlyWiki5 to generate a new target `index.html` file using `index.html.recipe` to incorporate the tiddler content from the `.json` files previously pulled from TiddlySpace.

Once this file is generated, the `bld` script automatically opens the file in your browser, so that you can manually invoke the "save changes" command from within the newly created document.  Before saving, be sure you have set the TiddlyWiki options for "chkGenerateAnRssFeed" and "chkSaveEmptyTemplate" (see AdvancedOptions), so that saving the document also creates new versions of `empty.html` and `index.xml` (the TiddlyWiki RSS file) in the target folder.  Saving changes also causes TiddlyWiki to generate some static HTML within the `index.html` file for display when Javascript is not enabled.

The `bld` script is paused while you perform this manual "save changes" step.  After saving, you can close the browser window, and then return to the window in which the `bld` script is running so you can "press any key to continue" the process.  The script then assembles an `empty.zip` containing the newly generated `empty.html` as well as a copy of `TiddlySaver.jar` from the tiddlywiki repository.  This .zip file will be delivered to end-users when they use the 'download' button on tiddlywiki.com.

The `bld` script also copies the new index.html and empty.html files to a `test` folder (naming them `index.x.y.z.html` and `empty.x.y.z.html`, respectively) within the tiddlywiki.com repository so that TiddlyWiki developers can use these 'archived' copies for comparison with future builds.

## Testing the build

After the `bld` script has assembled the new TiddlyWiki target files (.html, .xml, .jar, and .zip), `maketw` invokes the `test.bat/sh` script, which performs a comparison between the newly generated index.html file and a copy of the previous version of TiddlyWiki that is stored in the tiddlywiki.com repository as `test/index.html`.

Note: whenever a new version of TiddlyWiki is officially published, the new `index.html` file must be updated and committed to the repository so that future builds will be tested against the most recent published version of TiddlyWiki.

## Publishing to tiddlywiki.com

Once the `bld` and `test` sequence has completed, you have successfully built a new local copy of TiddlyWiki.  You can then publish the results to http://tiddlywiki.com by copying the newly generated files (index.html, index.xml, TiddlySaver.jar, empty.html, and empty.zip) from the target folder (i.e., cooked/x.y.z/) into the local github.tiddlywiki.com repository and then commit those changes to the remote repository.  The committed files will automatically become available at http://tiddlywiki.github.com (which is also served by redirection from http://tiddlywiki.com)

## Publishing to TiddlySpace

Finally, to publish the new release for use with TiddlySpace, you need to manually upload the empty tiddlywiki file at cooked/x.y.z/empty.html to http://tiddlywiki-releases.tiddlyspace.com. This file needs to be uploaded to two places:

    http://tiddlywiki-releases.tiddlyspace.com/upgrade
    http://tiddlywiki-releases.tiddlyspace.com/x.y.z

You need to be a member of the tiddlywiki-releases.tiddlyspace.com space to do this.
