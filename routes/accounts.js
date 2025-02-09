const express = require("express");
const router = express.Router();
const accounts = require("../controllers/accounts");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, accounts.getAllAccounts);
router.get(
  "/accounts-by-customer/:id",
  verifyUser,
  accounts.getAccountsByCustomer
);
router.get(
  "/balance-by-account/:account_number",
  verifyUser,
  accounts.getBalanceByAccount
);

module.exports = router;
