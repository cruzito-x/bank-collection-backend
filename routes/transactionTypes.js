const express = require('express');
const router = express.Router();
const transactionTypes = require("../controllers/transactionTypes");

router.get("/", transactionTypes.getTypes);
router.post("/save-new-type", transactionTypes.saveNewType);

module.exports = router;