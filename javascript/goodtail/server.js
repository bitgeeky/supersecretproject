var sys = require('util')
var spawn = require('child_process').spawn;
var filename = process.argv[2];
if (!filename)
  return sys.puts("Usage: node <server.js> <filename>");

var tail = spawn("node", ["./tail.js", filename]);

http = require('http');
http.createServer(function (req, res) {
  sys.puts("new connection..");
  res.writeHead(200, {'Content-Type': "text/plain;charset=UTF-8"});
  tail.stdout.on("data", function (data) {
    res.write(data);
  }); 
}).listen(3000);