const express = require("express");
const router = express.Router();
const transactionsTypes = require("../controllers/transactionsTypes");

router.get("/", transactionsTypes.getTypes);
router.post(
  "/save-new-transaction-type",
  transactionsTypes.saveNewTransactionType
);
router.put(
  "/update-transaction-type/:id",
  transactionsTypes.updateTransactionType
);
router.put(
  "/delete-transaction-type/:id",
  transactionsTypes.deleteTransactionType
);

module.exports = router;
