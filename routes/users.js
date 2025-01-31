const express = require("express");
const router = express.Router();
const users = require("../controllers/users");

router.get("/", users.getUsers);
router.get("/roles", users.getUsersRoles);
router.put("/update-user/:id", users.updateUser);
router.put("/update-user-role/:id", users.updateUserRole);

module.exports = router;
