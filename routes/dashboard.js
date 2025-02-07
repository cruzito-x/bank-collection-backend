const express = require("express");
const router = express.Router();
const dashboard = require("../controllers/dashboard");

router.get(
  "/get-latest-collector-and-collectorPayemnt-data",
  dashboard.getLatestCollectorAndCollectorPayemntData
);
router.get(
  "/transactions-by-dates/:startDay/:endDay/:amountFilter/:transactionTypeFilter",
  dashboard.getTransactionsByDates
);
router.get("/transactions-by-collector", dashboard.getTransactionsByCollector);
router.get(
  "/transactions-by-denomination",
  dashboard.getTransactionsByDenomination
);
router.get("/reports-by-date/:startDay/:endDay", dashboard.getReportsByDate);

module.exports = router;
