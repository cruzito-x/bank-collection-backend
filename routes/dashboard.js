const express = require("express");
const router = express.Router();
const dahsboard = require("../controllers/dashboard");

router.get("/transactions-by-collector", dahsboard.getTransactionsByCollector);

module.exports = router;
