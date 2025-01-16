const express = require("express");
const router = express.Router();
const paymentsCollectors = require("../controllers/paymentsCollectors");

router.get("/", paymentsCollectors.getCollectorsPayments);
router.post("/save-new-payment", paymentsCollectors.saveNewPayment);

module.exports = router;
