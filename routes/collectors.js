const express = require("express");
const router = express.Router();
const collectors = require("../controllers/collectors");

router.get("/", collectors.getCollectors);
router.post("/save-collector", collectors.saveNewCollector);
router.get(
  "/view-payments-collector-details/:id",
  collectors.viewPaymentsCollectorDetails
);
router.put("/update-collector/:id", collectors.updateCollector);
router.put("/delete-collector/:id", collectors.deleteCollector);
router.get("/search-collector/:collector?", collectors.searchCollector);

module.exports = router;
