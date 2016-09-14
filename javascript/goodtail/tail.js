var fs = require('fs')
var filePath = process.argv[2]

var bytesRead = 0

fs.open(filePath, 'r', function(err, fd) {
    fs.watchFile(filePath, function(curr,prev) {
	if(curr.size != prev.size){
	    var fileSize = curr.size;
	    var chunkSize = (fileSize - bytesRead);
	    if(fileSize > bytesRead){
		var buffer = new Buffer(chunkSize);
		fs.read(fd, buffer, 0, chunkSize, bytesRead, function(err, bytesRead, buffer){
		    process.stdout.write(buffer.toString());
		});
		bytesRead = fileSize;
	    }
	}
    });
});
