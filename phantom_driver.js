/*
Phantom.js script to run TiddlyWiki and save changes to local files
*/

// Get the existing page content
var fs = require("fs"), // Not the same as node.js's filesystem module
	env = require("system").env,
	original = fs.read("cooked/" + env["TIDDLYWIKI_RELEASE"] + "/index.html");

// Create a webpage and initialise it
var page = require("webpage").create();
page.viewportSize = {width: 1024,height: 800};

// Open TiddlyWiki
page.open("cooked/" + env["TIDDLYWIKI_RELEASE"] + "/index.html", function () {

	// Extract the save data by running the enclosed function in the context of the page. Note that
	// the enclosed function is not captured in a closure, and so cannot access variables in the outer scopes.
	var result = page.evaluate(function(original) {

		// Find the store area within the original text
		var posDiv = locateStoreArea(original);
		if(!posDiv) {
			return "Cannot find store area";
		}

		// Generate the main file
		var revised = updateOriginal(original,posDiv);

		// Generate the empty file
		var empty = original.substr(0,posDiv[0] + startSaveArea.length) + original.substr(posDiv[1]);

		// Generate the RSS file
		var rss = convertUnicodeToFileFormat(generateRss());

		// Return the whole lot
		return {
			revised: revised,
			empty: empty,
			rss: rss
		};

	},original);

	// Check for errors
	if(typeof result === "string") {
		console.log("Error: " + result);
	} else {
		// Save the files
		fs.write("cooked/" + env["TIDDLYWIKI_RELEASE"] + "/index.html",result.revised,"w");
		fs.write("cooked/" + env["TIDDLYWIKI_RELEASE"] + "/empty.html",result.empty,"w");
		fs.write("cooked/" + env["TIDDLYWIKI_RELEASE"] + "/index.xml",result.rss,"w");		
	}

	// Exit
    phantom.exit();

});
