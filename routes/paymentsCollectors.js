const express = require("express");
const router = express.Router();
const paymentsCollectors = require("../controllers/paymentsCollectors");

router.get("/", paymentsCollectors.getCollectorsPayments);

module.exports = router;
