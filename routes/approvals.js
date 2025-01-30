const express = require("express");
const router = express.Router();
const approvals = require("../controllers/approvals");

router.get("/notifications", approvals.getNotifications);
router.put(
  "/approve-or-reject-transaction/:approvalId/transaction/:transactionId/approved/:isApproved/authorized-by/:authorizer",
  approvals.approveOrRejectTransaction
);

module.exports = router;
