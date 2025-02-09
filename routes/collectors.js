const express = require("express");
const router = express.Router();
const collectors = require("../controllers/collectors");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, collectors.getCollectors);
router.post("/save-collector", verifyUser, collectors.saveNewCollector);
router.get(
  "/view-payments-collector-details/:id",
  verifyUser,
  collectors.viewPaymentsCollectorDetails
);
router.put("/update-collector/:id", verifyUser, collectors.updateCollector);
router.put("/delete-collector/:id", verifyUser, collectors.deleteCollector);
router.get(
  "/search-collector/:collector?",
  verifyUser,
  collectors.searchCollector
);

module.exports = router;
