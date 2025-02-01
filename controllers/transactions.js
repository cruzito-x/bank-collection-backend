const db = require("../config/db");

exports.getTransactions = (request, response) => {
  const transactions =
    "SELECT transactions.transaction_id as id, customers.name AS customer, customers.email AS customer_email, transactions.sender_account, receivers.name AS receiver, receivers.email AS receiver_email, transactions.receiver_account, transaction_types.transaction_type, transactions.amount, transactions.concept, transactions.status, transactions.date_hour AS datetime, cashier.username as realized_by, users.username as authorized_by FROM transactions INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users cashier ON cashier.id = transactions.realized_by LEFT JOIN users ON users.id = transactions.authorized_by ORDER BY datetime DESC";

  db.query(transactions, (error, result) => {
    console.error(error);
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getTransactionByCustomerAndAccountNumber = (request, response) => {
  const { id, account } = request.params;

  const transactionsByCustomerAndAccountNumber =
    "SELECT transactions.id, customers.name AS customer, receivers.name AS receiver, transaction_types.transaction_type, transactions.sender_account, transactions.amount, transactions.receiver_account, transactions.date_hour AS datetime, users.username AS authorized_by FROM transactions LEFT JOIN accounts ON accounts.account_number = transactions.sender_account OR accounts.account_number = transactions.receiver_account LEFT JOIN customers ON transactions.customer_id = customers.id LEFT JOIN customers AS receivers ON transactions.receiver_id = receivers.id LEFT JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id LEFT JOIN users ON users.id = transactions.authorized_by LEFT JOIN accounts AS sender_account ON sender_account.account_number = transactions.sender_account AND sender_account.deleted_at IS NULL LEFT JOIN accounts AS receiver_account ON receiver_account.account_number = transactions.receiver_account AND receiver_account.deleted_at IS NULL WHERE transactions.customer_id = ? AND accounts.account_number = ? AND customers.deleted_at IS NULL AND accounts.deleted_at IS NULL ORDER BY datetime DESC";

  db.query(
    transactionsByCustomerAndAccountNumber,
    [id, account],
    (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      return response.status(200).json(result);
    }
  );
};

exports.getCustomers = (request, response) => {
  const customersData =
    "SELECT customers.id, customers.name, customers.identity_doc, accounts.account_number FROM customers INNER JOIN accounts ON accounts.owner_id = customers.id WHERE customers.deleted_at IS NULL AND accounts.deleted_at IS NULL ORDER BY id ASC";

  db.query(customersData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.saveTransaction = (request, response) => {
  const {
    customer,
    transaction_type,
    sender_account_number,
    receiver_account_number,
    amount,
    concept,
  } = request.body;

  const realized_by = 1;
  let authorized_by = 1;

  const transactionsCounter =
    "SELECT (COUNT(*) + 1) AS totalTransactions FROM transactions";

  db.query(transactionsCounter, (error, result) => {
    if (error) {
      console.error(error);
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const transactionsNumber = result[0].totalTransactions;
    const transactionId = `TX${String(transactionsNumber).padStart(6, "0")}`;

    db.beginTransaction((error) => {
      if (error) {
        console.error("Error al iniciar la transacción:", error);
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      let receiver_id = null;
      let status = 2;

      if (transaction_type === 2 && amount >= 10000) {
        status = 1;
        authorized_by = null;

        const approvalsCounter =
          "SELECT (COUNT(*) + 1) AS totalApprovals FROM approvals";

        db.query(approvalsCounter, (error, result) => {
          if (error) {
            console.error("Error al obtener el número de aprobaciones:", error);
          }

          const approvalsNumber = result[0].totalApprovals;

          const waitingForApproval =
            "INSERT INTO approvals (approval_id, transaction_id, is_approved, authorizer_id, date_hour) VALUES (?, ?, ?, ?, ?)";
          const approvalId = `APPVL${String(approvalsNumber).padStart(6, "0")}`;

          db.query(
            waitingForApproval,
            [approvalId, transactionsNumber, null, null, null],
            (error, result) => {
              if (error) {
                console.error(
                  "Error al agregar a la lista de espera:",
                  error.message
                );
              }
            }
          );
        });
      }

      const saveTransaction =
        "INSERT INTO transactions (transaction_id, customer_id, sender_account, receiver_id, receiver_account, transaction_type_id, amount, concept, status, date_hour, realized_by, authorized_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

      if (transaction_type === 3) {
        const getReceiverByAccountNumber =
          "SELECT owner_id FROM accounts WHERE account_number = ?";

        db.query(
          getReceiverByAccountNumber,
          [receiver_account_number],
          (error, result) => {
            if (error) {
              console.error(error);
              return db.rollback(() => {
                response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              });
            }

            if (result.length === 0) {
              return db.rollback(() => {
                response
                  .status(404)
                  .json({ message: "Cuenta Destino No Encontrada" });
              });
            }

            receiver_id = result[0].owner_id;
            processTransaction();
          }
        );
      } else {
        processTransaction();
      }

      function processTransaction() {
        console.log(receiver_id);
        if (receiver_id === null) {
          receiver_id = customer;
        }

        db.query(
          saveTransaction,
          [
            transactionId,
            customer,
            sender_account_number,
            receiver_id,
            receiver_account_number,
            transaction_type,
            amount,
            concept,
            status,
            new Date(),
            realized_by,
            authorized_by,
          ],
          (error, result) => {
            if (error) {
              console.error(error);
              return db.rollback(() => {
                response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              });
            }

            if (transaction_type === 1) {
              const updateBalance =
                "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
              db.query(updateBalance, [amount, customer], transactionSuccess);
            } else if (transaction_type === 2) {
              const updateBalance =
                "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
              db.query(
                updateBalance,
                [amount < 10000 ? amount : 0, customer],
                transactionSuccess
              );
            } else if (transaction_type === 3) {
              const updateSenderBalance =
                "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
              db.query(
                updateSenderBalance,
                [amount, sender_account_number],
                (error, result) => {
                  if (error) {
                    return db.rollback(() => {
                      response
                        .status(500)
                        .json({ message: "Error Interno del Servidor" });
                    });
                  }

                  const updateReceiverBalance =
                    "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
                  db.query(
                    updateReceiverBalance,
                    [amount, receiver_account_number],
                    transactionSuccess
                  );
                }
              );
            }
          }
        );
      }

      function transactionSuccess(error, result) {
        if (error) {
          console.error("Error al actualizar balance:", error);
          return db.rollback(() => {
            response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          });
        }

        // Confirmar transacción
        db.commit((err) => {
          if (err) {
            console.error("Error al confirmar la transacción:", err);
            return db.rollback(() => {
              response
                .status(500)
                .json({ message: "Error Interno del Servidor" });
            });
          }

          return response
            .status(200)
            .json({ message: "¡Transacción Registrada Correctamente!" });
        });
      }
    });
  });
};
