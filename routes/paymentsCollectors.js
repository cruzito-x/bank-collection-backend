const express = require("express");
const router = express.Router();
const paymentsCollectors = require("../controllers/paymentsCollectors");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, paymentsCollectors.getCollectorsPayments);
router.get(
  "/total-payments-amount",
  verifyUser,
  paymentsCollectors.getTotalPaymentsAumount
);
router.get(
  "/payments-by-collector/:startDay/:endDay",
  verifyUser,
  paymentsCollectors.obtainedPaymentsByCollector
);
router.post("/save-new-payment", verifyUser, paymentsCollectors.saveNewPayment);
router.get(
  "/search-payments-collectors/:collector?",
  verifyUser,
  paymentsCollectors.searchPaymentsCollector
);

module.exports = router;
