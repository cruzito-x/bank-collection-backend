const express = require("express");
const router = express.Router();
const transactionsTypes = require("../controllers/transactionsTypes");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, transactionsTypes.getTypes);
router.post(
  "/save-new-transaction-type",
  verifyUser,
  transactionsTypes.saveNewTransactionType
);
router.put(
  "/update-transaction-type/:id",
  verifyUser,
  transactionsTypes.updateTransactionType
);
router.put(
  "/delete-transaction-type/:id",
  verifyUser,
  transactionsTypes.deleteTransactionType
);
router.get(
  "/search-transaction-type/:transaction_type?",
  verifyUser,
  transactionsTypes.searchTransactionType
);

module.exports = router;
