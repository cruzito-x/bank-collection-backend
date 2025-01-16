const express = require('express');
const router = express.Router();
const transactionsTypes = require("../controllers/transactionsTypes");

router.get("/", transactionsTypes.getTypes);
router.post("/save-new-type", transactionsTypes.saveNewType);

module.exports = router;