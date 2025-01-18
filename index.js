require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const bodyParser = require("body-parser");
const serverPort = process.env.server_port;

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes settings
const login = require("./routes/login");
const dashboard = require("./routes/dashboard");
const customers = require("./routes/customers");
const collectors = require("./routes/collectors");
const services = require("./routes/services");
const paymentsCollectors = require("./routes/paymentsCollectors");
const transactions = require("./routes/transactions");
const transactionTypes = require("./routes/transactionsTypes");
const users = require("./routes/users");
const audit = require("./routes/audit");

app.use("/login", login);
app.use("/dashboard", dashboard);
app.use("/customers", customers);
app.use("/collectors", collectors);
app.use("/services", services);
app.use("/payments-collectors", paymentsCollectors);
app.use("/transactions", transactions);
app.use("/transactions-types", transactionTypes);
app.use("/users", users);
app.use("/audit", audit);

app.listen(serverPort, (error) => {
  if (!error) {
    console.log(`Server is running on port ${serverPort}`);
  } else {
    console.log("Error: ", error);
  }
});
