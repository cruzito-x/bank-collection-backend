const express = require("express");
const router = express.Router();
const dashboard = require("../controllers/dashboard");

router.get(
  "/get-latest-collector-and-collector-payment-data",
  dashboard.getLatestCollectorAndCollectorPaymentData
);
router.get(
  "/transactions-by-dates/:startDay/:endDay/:amountFilter/:transactionTypeFilter",
  dashboard.getTransactionsByDates
);
router.get("/payments-by-collector", dashboard.getPaymentsByCollector);
router.get(
  "/payments-by-collector-denominations",
  dashboard.getPaymentsByCollectorDenominations
);
router.get(
  "/processed-amount-by-transactions-and-collectors-payments/:startDay/:endDay",
  dashboard.getProcessedAmountByTransactionsAndCollectorsPayments
);
router.get(
  "/approval-and-rejection-rates/:startDay/:endDay",
  dashboard.getApprovalAndRejectionRates
);
router.get(
  "/customers-with-the-most-money-paid",
  dashboard.getCustomersWithTheMostMoneyPaid
);
router.get("/reports-by-date/:startDay/:endDay", dashboard.getReportsByDate);

module.exports = router;
