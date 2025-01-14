require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");
const serverPort = process.env.server_port;

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());

// Routes settings
const login = require("./routes/login");
const users = require("./routes/users");

app.use("/login", login);
app.use("/users", users);

app.listen(serverPort, (error) => {
  if (!error) {
    console.log(`Server is running on port ${serverPort}`);
  } else {
    console.log("Error: ", error);
  }
});
