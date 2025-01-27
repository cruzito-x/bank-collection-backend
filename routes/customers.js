const express = require("express");
const router = express.Router();
const customers = require("../controllers/customers");

router.get("/", customers.getCustomers);
router.put("/update-customer/:id", customers.updateCustomer);

module.exports = router;