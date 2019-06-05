const http = require('https');
const fs = require('fs');

const w3cssFile = fs.createWriteStream("w3.css");
const w3cssUrl = "https://www.w3schools.com/w3css/4/w3.css";
const w3jsFile = fs.createWriteStream("w3.js");
const w3jsUrl = "https://www.w3schools.com/lib/w3.js";

http.get(w3cssUrl, (response) => {
    response.pipe(w3cssFile);
});
  
http.get(w3jsUrl, (response) => {
    response.pipe(w3jsFile);
});
