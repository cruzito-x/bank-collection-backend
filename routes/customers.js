const express = require("express");
const router = express.Router();
const customers = require("../controllers/customers");

router.get("/", customers.getCustomers);
router.put("/update-customer/:id", customers.updateCustomer);
router.put("/delete-customer/:id", customers.deleteCustomer);
router.get(
  "/search-customer/:name?/:identity_doc?",
  customers.searchCustomer
);

module.exports = router;
