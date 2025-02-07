const express = require("express");
const router = express.Router();
const approvals = require("../controllers/approvals");

router.get("/", approvals.getApprovals);
router.get("/notifications", approvals.getNotifications);
router.put(
  "/approve-or-reject-transaction/:approvalId/transaction/:transactionId/approved/:isApproved/authorized-by/:authorizer",
  approvals.approveOrRejectTransaction
);
router.get(
  "/search-approval/:transaction_id?/:authorized_by?",
  approvals.searchApproval
);
router.get("/latest-approval", approvals.latestApproval);

module.exports = router;
