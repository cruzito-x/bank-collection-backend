require("dotenv").config();
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const fs = require("fs");
const path = require("path");
const moment = require("moment");
const app = express();
const serverPort = process.env.server_port;
const logsFolder = path.join(__dirname, "logs");

if (!fs.existsSync(logsFolder)) {
  fs.mkdirSync(logsFolder, { recursive: true });
}

const logs = fs.createWriteStream(path.join(logsFolder, "express.log"), {
  flags: "a",
});

console.log = (...log) => {
  logs.write(
    `[LOG] ${moment(new Date()).format("YYYY/MM/DD HH:mm")} - ${log.join(
      " "
    )}\n`
  );
};

console.error = (...log) => {
  logs.write(
    `[ERROR] ${moment(new Date()).format("YYYY/MM/DD HH:mm")} - ${log.join(
      " "
    )}\n`
  );
};

app.use(cors({ origin: "*" }));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(morgan("combined", { stream: logs }));

// Middlewares Instances
const { authMiddleware } = require("./middleware/authMiddleware");
const {
  timeRestrictionMiddleware,
} = require("./middleware/timeRestrictionMiddleware");

// Routes settings
app.get("/", timeRestrictionMiddleware, (request, response) => {
  return response.status(200).json({ message: "Server Online" });
});
const login = require("./routes/login");
const dashboard = require("./routes/dashboard");
const customers = require("./routes/customers");
const collectors = require("./routes/collectors");
const services = require("./routes/services");
const paymentsCollectors = require("./routes/paymentsCollectors");
const transactions = require("./routes/transactions");
const accounts = require("./routes/accounts");
const transactionTypes = require("./routes/transactionsTypes");
const approvals = require("./routes/approvals");
const users = require("./routes/users");
const audit = require("./routes/audit");

app.use("/login", timeRestrictionMiddleware, login);
app.use("/dashboard", authMiddleware, timeRestrictionMiddleware, dashboard);
app.use("/customers", authMiddleware, timeRestrictionMiddleware, customers);
app.use("/collectors", authMiddleware, timeRestrictionMiddleware, collectors);
app.use("/services", authMiddleware, timeRestrictionMiddleware, services);
app.use(
  "/payments-collectors",
  authMiddleware,
  timeRestrictionMiddleware,
  paymentsCollectors
);
app.use(
  "/transactions",
  authMiddleware,
  timeRestrictionMiddleware,
  transactions
);
app.use("/accounts", authMiddleware, timeRestrictionMiddleware, accounts);
app.use(
  "/transactions-types",
  authMiddleware,
  timeRestrictionMiddleware,
  transactionTypes
);
app.use("/approvals", authMiddleware, timeRestrictionMiddleware, approvals);
app.use("/users", authMiddleware, timeRestrictionMiddleware, users);
app.use("/audit", authMiddleware, timeRestrictionMiddleware, audit);

app.listen(serverPort, (error) => {
  if (!error) {
    console.log(`Server is running on port ${serverPort}`);
  } else {
    console.log("Error: ", error);
  }
});
