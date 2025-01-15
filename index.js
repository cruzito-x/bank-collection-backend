require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");
const serverPort = process.env.server_port;

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));

// Routes settings
const login = require("./routes/login");
const collectors = require("./routes/collectors");
const transactionTypes = require("./routes/transactionTypes");
const users = require("./routes/users");
const audit = require("./routes/audit");

app.use("/login", login);
app.use("/collectors", collectors);
app.use("/transaction-types", transactionTypes);
app.use("/users", users);
app.use("/audit", audit);

app.listen(serverPort, (error) => {
  if (!error) {
    console.log(`Server is running on port ${serverPort}`);
  } else {
    console.log("Error: ", error);
  }
});
