const express = require("express");
const router = express.Router();
const transactions = require("../controllers/transactions");

router.get("/", transactions.getTransactions);
router.get(
  "/transactions-by-customer/:id",
  transactions.getTransactionByCustomer
);

module.exports = router;
