const fs = require("fs");
const readLine = require("readline");
const greetings = require('./greetings');

const rl = readLine.createInterface({
    input: process.stdin,
    output: process.stdout,
});


rl.question("Type your Name:", function(name) {
    const greeting = greetings.generateGreeting(name);

    fs.appendFile('output.txt', greeting + '\n', function(err){
        if(err) {
            return console.error("Error occured while saving greeting to the output.txt file", err);
        } else {
            console.log("Greeting was saved successfully!");
        }

        // Close the readline interface after the file writing is complete
        rl.close();
    });
});

// Listen for the 'close' event to exit the program gracefully
rl.on('close', function () {
    process.exit(0);
  });