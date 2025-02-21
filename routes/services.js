const express = require("express");
const router = express.Router();
const services = require("../controllers/services");

router.get("/", services.getServices);
router.post("/save-service", services.saveNewService);
router.get(
  "/services-by-collector/:collector_id",
  services.getServicesByCollector
);
router.get(
  "/view-payments-by-service-details/:id/:startDay/:endDay",
  services.viewPaymentsByServiceDetails
);
router.put("/update-service/:id", services.updateService);
router.put("/delete-service/:id", services.deleteService);
router.get("/search-service/:collector?/:service?", services.searchService);

module.exports = router;
