const express = require("express");
const router = express.Router();
const users = require("../controllers/users");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, users.getUsers);
router.get("/roles", verifyUser, users.getUsersRoles);
router.put("/update-user/:id", verifyUser, users.updateUser);
router.put("/update-user-role/:id", verifyUser, users.updateUserRole);
router.put("/delete-user/:id", verifyUser, users.deleteUser);
router.get("/search-user/:username?/:role?", verifyUser, users.searchUser);

module.exports = router;
