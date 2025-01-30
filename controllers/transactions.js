const db = require("../config/db");

exports.getTransactions = (request, response) => {
  const transactions =
    "SELECT transactions.transaction_id as id, customers.name AS customer, customers.email AS customer_email, receivers.name AS receiver, receivers.email AS receiver_email, transaction_types.transaction_type, transactions.amount, transactions.concept, transactions.status, transactions.date_hour AS datetime, users.username as authorized_by FROM transactions INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users ON users.id = transactions.authorized_by ORDER BY datetime DESC";

  db.query(transactions, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getTransactionByCustomer = (request, response) => {
  const { id } = request.params;

  const transactionsByCustomer =
    "SELECT transactions.id, customers.name AS customer, receivers.name AS receiver, transaction_types.transaction_type, transactions.amount, transactions.date_hour AS datetime, users.username AS authorized_by FROM transactions LEFT JOIN customers ON transactions.customer_id = customers.id LEFT JOIN customers AS receivers ON transactions.receiver_id = receivers.id LEFT JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id LEFT JOIN users ON users.id = transactions.authorized_by WHERE transactions.customer_id = ? ORDER BY datetime DESC";

  db.query(transactionsByCustomer, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getCustomersData = (request, response) => {
  const customersData =
    "SELECT id, name, identity_doc, account_number FROM customers WHERE deleted_at IS NULL ORDER BY id ASC";

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
  const { customer, transaction_type, account_number, amount, concept } =
    request.body;

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

    db.beginTransaction((err) => {
      if (err) {
        console.error("Error al iniciar la transacción:", err);
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      let receiver_id = null;
      let status = 2;

      if (transaction_type === 2 && amount >= 10000) {
        status = 1;

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

          console.log(
            "Approval Id: ",
            approvalId,
            "Transaction Id: ",
            transactionsNumber
          );

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
        "INSERT INTO transactions (transaction_id, customer_id, receiver_id, transaction_type_id, amount, concept, status, date_hour, authorized_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

      if (transaction_type === 3) {
        const getReceiverByAccountNumber =
          "SELECT id FROM customers WHERE account_number = ?";

        db.query(
          getReceiverByAccountNumber,
          [account_number],
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

            receiver_id = result[0].id;
            processTransaction(); // Ejecuta la transacción con receptor válido
          }
        );
      } else {
        processTransaction(); // Ejecuta la transacción sin receptor
      }

      function processTransaction() {
        if (receiver_id === null) {
          receiver_id = customer;
        }

        db.query(
          saveTransaction,
          [
            transactionId,
            customer,
            receiver_id,
            transaction_type,
            amount,
            concept,
            status,
            new Date(),
            1,
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

            // Ejecutar el tipo de transacción correspondiente
            if (transaction_type === 1) {
              // DEPÓSITO: Sumar balance al cliente
              const updateBalance = `UPDATE customers SET balance = balance + ? WHERE id = ?`;
              db.query(updateBalance, [amount, customer], transactionSuccess);
            } else if (transaction_type === 2) {
              // RETIRO: Restar balance al cliente
              const updateBalance = `UPDATE customers SET balance = balance - ? WHERE id = ?`;
              db.query(updateBalance, [amount, customer], transactionSuccess);
            } else if (transaction_type === 3) {
              // TRANSFERENCIA: Restar al remitente y sumar al receptor
              const updateSenderBalance = `UPDATE customers SET balance = balance - ? WHERE id = ?`;
              db.query(
                updateSenderBalance,
                [amount, customer],
                (error, result) => {
                  if (error) {
                    console.error(
                      "Error al restar balance del remitente:",
                      error
                    );
                    return db.rollback(() => {
                      response
                        .status(500)
                        .json({ message: "Error Interno del Servidor" });
                    });
                  }

                  const updateReceiverBalance = `UPDATE customers SET balance = balance + ? WHERE id = ?`;
                  db.query(
                    updateReceiverBalance,
                    [amount, receiver_id],
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
