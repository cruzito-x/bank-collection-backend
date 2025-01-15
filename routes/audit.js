const express = require("express");
const router = express.Router();
const audit = require("../controllers/audit");

router.get("/", audit.getAudits);

module.exports = router;