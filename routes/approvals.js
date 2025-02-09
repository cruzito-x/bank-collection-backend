const express = require("express");
const router = express.Router();
const approvals = require("../controllers/approvals");
const { verifyUser } = require("../middleware/authMiddleware");

router.get("/", verifyUser, approvals.getApprovals);
router.get("/notifications", verifyUser, approvals.getNotifications);
router.put(
  "/approve-or-reject-transaction/:approvalId/transaction/:transactionId/approved/:isApproved/authorized-by/:authorizer",
  verifyUser,
  approvals.approveOrRejectTransaction
);
router.get(
  "/search-approval/:transaction_id?/:authorized_by?",
  verifyUser,
  approvals.searchApproval
);
router.get("/latest-approval", verifyUser, approvals.latestApproval);

module.exports = router;
