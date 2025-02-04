const express = require("express");
const router = express.Router();
const transactions = require("../controllers/transactions");

router.get("/", transactions.getTransactions);
router.get(
  "/transactions-by-customer/:id/account/:account",
  transactions.getTransactionByCustomerAndAccountNumber
);
router.get("/customers", transactions.getCustomers);
router.post("/save-new-transaction", transactions.saveTransaction);
router.get(
  "/search-transactions/:transaction_id?/:realized_by?/:transaction_type?/:date?",
  transactions.searchTransaction
);

module.exports = router;
