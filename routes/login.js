const express = require("express");
const router = express.Router();
const login = require("../controllers/login");

router.post("/", login.login);
router.get("/logout/:id", login.logout);

module.exports = router;
