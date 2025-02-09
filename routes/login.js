const express = require("express");
const router = express.Router();
const login = require("../controllers/login");
const { verifyUser } = require("../middleware/authMiddleware");

router.post("/", login.login);
router.get("/logout/:id", verifyUser, login.logout);

module.exports = router;
