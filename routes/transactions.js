const express = require("express");
const router = express.Router();
const transactions = require("../controllers/transactions");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, transactions.getTransactions);
router.get(
  "/transactions-by-customer/:id/account/:account",
  verifyUser,
  transactions.getTransactionByCustomerAndAccountNumber
);
router.post("/save-new-transaction", verifyUser, transactions.saveTransaction);
router.get(
  "/search-transactions/:transaction_id?/:realized_by?/:transaction_type?/:date?",
  verifyUser,
  transactions.searchTransaction
);
router.get("/user-by-pin/:pin", verifyUser, transactions.getUserByPin);

module.exports = router;
