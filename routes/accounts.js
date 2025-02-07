const express = require("express");
const router = express.Router();
const accounts = require("../controllers/accounts");

router.get("/", accounts.getAllAccounts);
router.get("/accounts-by-customer/:id", accounts.getAccountsByCustomer);

module.exports = router;
