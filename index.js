require('dotenv').config();
const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const server_port = process.env.SERVER_PORT;

app.use(cors({ origin: '*' }));

// Routes settings
const login = require("./routes/login");
app.use("/login", login);

app.listen(server_port, (error) => {
  if(!error) {
    console.log(`Server is running on port ${server_port}`);
  }
  else {
    console.log('Error: ', error);
  }
});