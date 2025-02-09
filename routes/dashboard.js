const express = require("express");
const router = express.Router();
const dashboard = require("../controllers/dashboard");
const { verifyUser } = require("../middleware/authMiddleware");

router.get(
  "/get-latest-collector-and-collector-payment-data",
  verifyUser,
  dashboard.getLatestCollectorAndCollectorPaymentData
);
router.get(
  "/transactions-by-dates/:startDay/:endDay/:amountFilter/:transactionTypeFilter",
  verifyUser,
  dashboard.getTransactionsByDates
);
router.get("/payments-by-collector", dashboard.getPaymentsByCollector);
router.get(
  "/payments-by-collector-denominations",
  verifyUser,
  dashboard.getPaymentsByCollectorDenominations
);
router.get(
  "/processed-amount-by-transactions-and-collectors-payments/:startDay/:endDay",
  verifyUser,
  dashboard.getProcessedAmountByTransactionsAndCollectorsPayments
);
router.get(
  "/approval-and-rejection-rates/:startDay/:endDay",
  verifyUser,
  dashboard.getApprovalAndRejectionRates
);
router.get(
  "/customers-with-the-most-money-paid",
  verifyUser,
  dashboard.getCustomersWithTheMostMoneyPaid
);
router.get(
  "/reports-by-date/:startDay/:endDay",
  verifyUser,
  dashboard.getReportsByDate
);

module.exports = router;
