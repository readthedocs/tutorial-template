'use strict';

const express = require('express');
const http = require('http');
const path = require('path');

const app = express();

const port = process.env.PORT || 8080;

console.log(__dirname)

app.use(express.static(__dirname + '/webapp/public'));

app.get('/*', (req, res) => res.sendFile(path.join(__dirname)));

const server = http.createServer(app);

server.listen(port, () => console.log(`App running on: http://localhost:${port}`));
