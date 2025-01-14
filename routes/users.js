const express = require("express");
const router = express.Router();
const users = require("../controllers/users");

router.get("/", users.getUsers);
router.get("/roles", users.getUsersRoles);

module.exports = router;
