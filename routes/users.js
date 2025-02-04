const express = require("express");
const router = express.Router();
const users = require("../controllers/users");

router.get("/", users.getUsers);
router.get("/roles", users.getUsersRoles);
router.put("/update-user/:id", users.updateUser);
router.put("/update-user-role/:id", users.updateUserRole);
router.put("/delete-user/:id", users.deleteUser);
router.get("/search-user/:username?/:role?", users.searchUser);

module.exports = router;
