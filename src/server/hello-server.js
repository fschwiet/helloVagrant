
var path = require("path");

// Load the http module to create an http server.
var http = require('http');

// Configure our HTTP server to respond with Hello World to all requests.
var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\n" + request.url + "\n" + path.resolve("."));
});

server.on('error', function(e) {
	console.error("error: " + e.code);
	console.error(e);
});


process.on('uncaughtException', function(e) {
	console.error("uncaughtException");
	console.error(e);
});

// Listen on port 8000, IP defaults to 127.0.0.1
server.listen(8080);

// Put a friendly message on the terminal
console.log("Server running at http://*:8080/");

function showStatus() {
	console.log("running...");

	setInterval(showStatus, 60 * 1000);
}

showStatus();

