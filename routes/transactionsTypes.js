const express = require("express");
const router = express.Router();
const transactionsTypes = require("../controllers/transactionsTypes");

router.get("/", transactionsTypes.getTypes);
router.post("/save-new-transaction-type", transactionsTypes.saveNewTransactionType);

module.exports = router;
