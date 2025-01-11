require('dotenv').config();
const express = require('express');
const app = express();
const server_port = process.env.SERVER_PORT;

app.get('/', (req, res) => {
  res.send('');
});

app.listen(server_port, (error) => {
  if(!error) {
    console.log(`Server is running on port ${server_port}`);
  }
  else {
    console.log('Error: ', error);
  }
});