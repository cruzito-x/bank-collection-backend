const express = require("express");
const router = express.Router();
const customers = require("../controllers/customers");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, customers.getCustomers);
router.put("/update-customer/:id", verifyUser, customers.updateCustomer);
router.put("/delete-customer/:id", verifyUser, customers.deleteCustomer);
router.get(
  "/search-customer/:name?/:identity_doc?",
  verifyUser,
  customers.searchCustomer
);

module.exports = router;
