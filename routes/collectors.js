const express = require("express");
const router = express.Router();
const collectors = require("../controllers/collectors");

router.get("/", collectors.getCollectors);
router.post("/save-collector", collectors.saveNewCollector);
router.get("/view-payments-collector-details/:id", collectors.viewPaymentsCollectorDetails);

module.exports = router;
