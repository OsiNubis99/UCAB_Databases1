var pg = require("pg");

var client = new pg.Client({
	host: "ec2-3-214-136-47.compute-1.amazonaws.com",
	user: "tjtqpztmkgdsdv",
	password: "f2949bbe7bb47b7ea2f6b654b721645e23d27955d8d8b1fe24cc7cbe4d95de49",
	database: "d2bu8pv1laim5f",
	port: "5432",
	ssl: {
		rejectUnauthorized: false,
	},
});

client.connect().then(() => {
	console.log("DB connected");
});
module.exports = client;
