const express = require("express");
const router = express.Router();
const audit = require("../controllers/audit");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, audit.getAudits);
router.get("/search-audit/:username?/:date?", verifyUser, audit.searchAudit);

module.exports = router;
