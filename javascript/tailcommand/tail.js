var fs = require('fs')
var filePath = process.argv[2]

file = fs.readFileSync(filePath);
process.stdout.write(file.toString('utf-8'))

var oldFileSize = file.length
fs.watch(filePath, function(event, filename) {
    if(filename && event == "change"){
	file = fs.readFileSync(filePath)
	newFileSize = file.length
	if(oldFileSize < newFileSize){
	    process.stdout.write(file.slice(oldFileSize, newFileSize).toString('utf-8'))
	    oldFileSize = newFileSize
	}
    }
    else{
	console.log('filename not provided')
    }
})
