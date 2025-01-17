const express = require("express");
const router = express.Router();
const collectors = require("../controllers/collectors");

router.get("/", collectors.getCollectors);
router.post("/save-collector", collectors.saveNewCollector);

module.exports = router;
