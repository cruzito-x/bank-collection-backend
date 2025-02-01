const express = require("express");
const router = express.Router();
const paymentsCollectors = require("../controllers/paymentsCollectors");

router.get("/", paymentsCollectors.getCollectorsPayments);
router.get(
  "/total-payments-amount",
  paymentsCollectors.getTotalPaymentsAumount
);
router.get("/payments-by-collector", paymentsCollectors.obtainedPaymentsByCollector);
router.post("/save-new-payment", paymentsCollectors.saveNewPayment);

module.exports = router;
