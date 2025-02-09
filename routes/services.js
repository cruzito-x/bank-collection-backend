const express = require("express");
const router = express.Router();
const services = require("../controllers/services");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, services.getServices);
router.post("/save-service", verifyUser, services.saveNewService);
router.get(
  "/services-by-collector/:collector_id",
  verifyUser,
  services.getServicesByCollector
);
router.get(
  "/view-payments-by-service-details/:id",
  services.viewPaymentsByServiceDetails
);
router.put("/update-service/:id", verifyUser, services.updateService);
router.put("/delete-service/:id", verifyUser, services.deleteService);
router.get(
  "/search-service/:collector?/:service?",
  verifyUser,
  services.searchService
);

module.exports = router;
