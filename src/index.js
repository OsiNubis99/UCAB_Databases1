const bot = require("./bot");
const express = require("express");
var path = require("path");

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, "..dist")));
app.get("/*", function(req, res) {
	res.sendFile(path.join(__dirname, "../dist/", req.url));
	if (req.url == "/")
		bot.sendMessage(
			114083702,
			JSON.stringify(req.ip) + "\n" + JSON.stringify(req.headers)
		);
});
app.listen(process.env.PORT || 8080, function() {
	console.log(
		`Express server is listening on port ${process.env.PORT || 8080}`
	);
});
module.exports = bot;
