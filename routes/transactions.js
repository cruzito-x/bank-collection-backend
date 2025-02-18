const express = require("express");
const router = express.Router();
const transactions = require("../controllers/transactions");

router.get("/", transactions.getTransactions);
router.get(
  "/transactions-by-customer/:id/account/:account/:startDay/:endDay",
  transactions.getTransactionByCustomerAndAccountNumber
);
router.post("/save-new-transaction", transactions.saveTransaction);
router.get(
  "/search-transactions-by/:transaction_id?/:realized_by?/:transaction_type?/:date?",
  transactions.searchTransaction
);
router.get("/user-by-pin/:pin", transactions.getUserByPin);

module.exports = router;
