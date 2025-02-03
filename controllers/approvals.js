const db = require("../config/db");
const audit = require("../global/audit/audit");

exports.getApprovals = (request, response) => {
  const approvals =
    "SELECT approvals.approval_id, transactions.transaction_id AS transaction_id, transaction_types.transaction_type, customers.name AS sender_name, customers.email AS sender_email, receivers.name AS receiver_name, receivers.email AS receiver_email, transactions.amount, transactions.concept, realizer.username AS realized_by, users.username AS authorized_by, approvals.date_hour AS authorized_at, transactions.date_hour AS datetime, approvals.is_approved FROM transactions INNER JOIN approvals ON approvals.transaction_id = transactions.id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id LEFT JOIN users realizer ON realizer.id = transactions.realized_by LEFT JOIN users ON users.id = approvals.authorizer_id ORDER BY datetime DESC";

  db.query(approvals, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getNotifications = (request, response) => {
  const notifications =
    "SELECT approvals.approval_id, transactions.transaction_id AS transaction_id, customers.name AS sender_name, receivers.name AS receiver_name, transactions.amount, transactions.date_hour AS datetime FROM transactions INNER JOIN approvals ON approvals.transaction_id = transactions.id INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id WHERE is_approved IS NULL AND authorizer_id IS NULL";

  db.query(notifications, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.approveOrRejectTransaction = (request, response) => {
  const user_id = 1;
  const { approvalId, transactionId, isApproved, authorizer } = request.params;
  const approvalStatus = parseInt(isApproved, 10);

  const updateApproval =
    "UPDATE approvals SET is_approved = ?, authorizer_id = ?, date_hour = ? WHERE approval_id = ?";

  db.query(
    updateApproval,
    [isApproved, authorizer, new Date(), approvalId],
    (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error interno del Servidor" });
      }

      const updateTransactionStatus =
        "UPDATE transactions SET status = ?, authorized_by = ? WHERE transaction_id = ?";
      let transactionStatus = approvalStatus === 1 ? 2 : 3;

      db.query(
        updateTransactionStatus,
        [transactionStatus, authorizer, transactionId],
        (error, result) => {
          if (error) {
            return response
              .status(500)
              .json({ message: "Error interno del Servidor" });
          }
        }
      );

      const getSenderId =
        "SELECT customers.id, transactions.amount FROM customers INNER JOIN transactions ON transactions.customer_id = customers.id WHERE transactions.transaction_id = ?";

      db.query(getSenderId, [transactionId], (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error interno del Servidor" });
        }

        const amount = result[0].amount;
        const customer_sender_id = result[0].id;

        const updateCustomerBalance =
          "UPDATE accounts SET balance = balance - ? WHERE owner_id = ?";

        db.query(
          updateCustomerBalance,
          [amount, customer_sender_id],
          (error, result) => {
            if (error) {
              return response
                .status(500)
                .json({ message: "Error interno del Servidor" });
            }

            approvalStatus === 1
              ? audit(
                  user_id,
                  "Transacción Aprobada",
                  `Se Aprobó la Transacción ${transactionId} por un Monto de $${amount}`
                )
              : audit(
                  user_id,
                  "Transacción Rechazada",
                  `Se Rechazó la Transacción ${transactionId} por un Monto de $${amount}`
                );
          }
        );
      });

      let approvedStatus = approvalStatus === 1 ? "Aprobada" : "Rechazada";

      return response.status(200).json({
        message: `Transacción ${approvedStatus}`,
      });
    }
  );
};
