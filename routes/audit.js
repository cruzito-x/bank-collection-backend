const express = require("express");
const router = express.Router();
const audit = require("../controllers/audit");

router.get("/", audit.getAudits);
router.get("/search-audit/:username?/:date?", audit.searchAudit);

module.exports = router;
