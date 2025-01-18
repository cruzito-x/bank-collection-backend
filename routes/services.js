const express = require("express");
const router = express.Router();
const services = require("../controllers/services");

router.get("/", services.getServices);
router.get("/services-by-collector/:collector_id", services.getServicesByCollector);

module.exports = router;
