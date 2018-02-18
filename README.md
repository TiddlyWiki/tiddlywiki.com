https://github.com/TiddlyWiki/tiddlywiki.com


## Description

This repository contains the tools required to create the site http://classic.tiddlywiki.com/ and build TiddlyWiki Classic from its components.

[TiddlyWiki repository](https://github.com/TiddlyWiki/tiddlywiki/) contains both the content for classic.tiddlywiki.com (the content/ folder) and TiddlyWiki Classic components. Legacy tools to pull content for classic.tiddlywiki.com from TiddlySpace are not removed yet.


## Prerequisites

The following steps prepare your machine for building classic.tiddlywiki.com:

1. Install the latest version of `nodejs` from http://www.nodejs.org
2. If necessary, install the command line tool curl to retrieve content from TiddlySpace. For Windows systems, it can be downloaded from http://curl.haxx.se/download.html
3. If necessary, install a `diff` program to compare versions of TiddlyWiki for testing after building. Mac OS X users can use `opendiff` that ships with XCode. Two options for Windows users are [WinDiff](http://www.grigsoft.com/download-windiff.htm) and [ExamDiff](http://www.prestosoft.com/edp_examdiff.asp)
4. Install phantomjs with `npm install -g phantomjs` (for Windows, you may also download the .exe directly)
5. Checkout or download the following repositories from GitHub:

	* https://github.com/TiddlyWiki/TiddlyWiki for the TiddlyWiki core source code. You can either download the latest version or visit https://github.com/TiddlyWiki/tiddlywiki/tags to download a specific tagged version
	* https://github.com/Jermolene/TiddlyWiki5 for TiddlyWiki5
	* https://github.com/TiddlyWiki/tiddlywiki.github.com for the TiddlyWiki GitHub Pages (only required if you are actually publishing the build to tiddlywiki.com)

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

## Overview

The batch files provided for Windows and OS X/Linux currently work slightly differently.

## Building on Windows

The build process is divided into several parts: `setenv`, `bld`, and `test`.  You can run each part separately, or invoke a complete build sequence by running `maketw`, which then automatically calls upon each separate part of the process.

These steps should be performed with the current directory set to the classic.tiddlywiki.com repository.

### Setting up batch files

Edit the `setenv.bat/sh` script to set:

* the correct release version number for TiddlyWiki
* the path for the TW5 repository
* the path locations of the `curl` and `diff` programs you have installed
* the location of a web browser (phantom.js)

`setenv` is invoked automatically by each part of the build process, so that all build scripts share the same environment variables.

### Cooking TiddlyWiki

The `bld.bat/sh` script clears the target folder, `cooked/x.y.z` (where x.y.z is the new build release number) and then invokes TiddlyWiki5 to generate a new target `index.html` file using `index.html.recipe` to incorporate the tiddler content.

Once this file is generated, the `bld` script automatically opens the file in your browser, so that you can manually invoke the "save changes" command from within the newly created document.  Before saving, be sure you have set the TiddlyWiki options for "chkGenerateAnRssFeed" and "chkSaveEmptyTemplate" (see AdvancedOptions), so that saving the document also creates new versions of `empty.html` and `index.xml` (the TiddlyWiki RSS file) in the target folder.  Saving changes also causes TiddlyWiki to generate some static HTML within the `index.html` file for display when Javascript is not enabled.

The `bld` script is paused while you perform this manual "save changes" step.  After saving, you can close the browser window, and then return to the window in which the `bld` script is running so you can "press any key to continue" the process.  The script then assembles an `empty.zip` containing the newly generated `empty.html` as well as a copy of `TiddlySaver.jar` from the tiddlywiki repository.  This .zip file will be delivered to end-users when they use the 'download' button on tiddlywiki.com.

The `bld` script also copies the new index.html and empty.html files to a `test` folder (naming them `index.x.y.z.html` and `empty.x.y.z.html`, respectively) within the tiddlywiki.com repository so that TiddlyWiki developers can use these 'archived' copies for comparison with future builds.

### Testing the build

After the `bld` script has assembled the new TiddlyWiki target files (.html, .xml, .jar, and .zip), `maketw` invokes the `test.bat/sh` script, which performs a comparison between the newly generated index.html file and a copy of the previous version of TiddlyWiki that is stored in the tiddlywiki.com repository as `test/index.html`.

Note: whenever a new version of TiddlyWiki is officially published, the new `index.html` file must be updated and committed to the repository so that future builds will be tested against the most recent published version of TiddlyWiki.

### Publishing to tiddlywiki.com

Once the `bld` and `test` sequence has completed, you have successfully built a new local copy of TiddlyWiki.  You can then publish the results to http://classic.tiddlywiki.com by copying the newly generated files (index.html, index.xml, TiddlySaver.jar, empty.html, and empty.zip) from the target folder (i.e., cooked/x.y.z/) into the local github.tiddlywiki.com repository and then commit those changes to the remote repository.  The committed files will automatically become available at http://tiddlywiki.github.com (which is also served by redirection from http://tiddlywiki.com).  If you are not a TiddlyWiki team member, you can instead fork the github.tiddlywiki.com repository, update your fork and create a pull request but keep in mind that content of [the main TiddlyWiki repository](https://github.com/TiddlyWiki/TiddlyWiki) should be updated accordingly, otherwise the change in core/content is likely to get lost with the next update.

## Building on Unix

Execute `./bld.sh` to:

* build TiddlyWiki using TW5
* run the index.html  through Phantomjs to generate the RSS feed and `<title>` tag content
