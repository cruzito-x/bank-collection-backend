const db = require("../config/db");
const audit = require("../global/audit/audit");
const moment = require("moment");
const crypto = require("crypto");

exports.getTransactions = (request, response) => {
  const transactions =
    "SELECT transactions.transaction_id as id, customers.name AS customer, customers.email AS customer_email, CONCAT('**** **** **** ', RIGHT(transactions.sender_account, 4)) AS sender_account, receivers.name AS receiver, receivers.email AS receiver_email, CONCAT('**** **** **** ', RIGHT(transactions.receiver_account, 4)) AS receiver_account, transaction_types.transaction_type, transactions.amount, transactions.concept, transactions.status, transactions.date_hour AS datetime, cashier.username as realized_by, users.username as authorized_by FROM transactions INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users cashier ON cashier.id = transactions.realized_by LEFT JOIN users ON users.id = transactions.authorized_by ORDER BY datetime DESC";

  db.query(transactions, (error, result) => {
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
    "SELECT DISTINCT transactions.id,transactions.transaction_id, customers.name AS customer, receivers.name AS receiver, transaction_types.transaction_type, CONCAT('**** **** **** ', RIGHT(transactions.sender_account, 4)) AS sender_account, transactions.amount, CONCAT('**** **** **** ', RIGHT(transactions.receiver_account, 4)) AS receiver_account, transactions.date_hour AS datetime, users.username AS authorized_by FROM transactions LEFT JOIN customers ON transactions.customer_id = customers.id LEFT JOIN customers AS receivers ON transactions.receiver_id = receivers.id LEFT JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id LEFT JOIN users ON users.id = transactions.authorized_by LEFT JOIN accounts AS sender_account ON sender_account.account_number = transactions.sender_account AND sender_account.deleted_at IS NULL LEFT JOIN accounts AS receiver_account ON receiver_account.account_number = transactions.receiver_account AND receiver_account.deleted_at IS NULL WHERE ((transactions.sender_account = ? AND transactions.customer_id = ?) OR (transactions.receiver_account = ? AND transactions.receiver_id = ?)) AND customers.deleted_at IS NULL ORDER BY datetime DESC";

  db.query(
    transactionsByCustomerAndAccountNumber,
    [account, id, account, id],
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

exports.saveTransaction = (request, response) => {
  const user_id = request.headers["user_id"];
  const {
    customer,
    transaction_type,
    sender_account_number,
    receiver_account_number,
    amount,
    concept,
  } = request.body;

  const realized_by = user_id;
  let authorized_by = user_id;

  if (!customer || !transaction_type || !sender_account_number || !amount) {
    return response
      .status(400)
      .json({ message: "Por Favor, Rellene Todos los Campos" });
  }

  if (transaction_type !== 1) {
    const getBalanceAndCompareData =
      "SELECT balance FROM accounts WHERE account_number = ?";

    db.query(
      getBalanceAndCompareData,
      [sender_account_number],
      (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        const balance = result[0].balance;

        if (amount > balance) {
          return response.status(400).json({
            message: "Saldo Insuficiente para Completar la Transacción",
          });
        }

        validateOnGoingTransaction();
      }
    );
  } else {
    validateOnGoingTransaction();
  }

  function validateOnGoingTransaction() {
    const compareSender =
      "SELECT * FROM transactions WHERE status = 1 AND sender_account = ?";

    db.query(compareSender, [sender_account_number], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      if (result.length > 0) {
        return response
          .status(400)
          .json({ message: "Esta Cuenta ya Posee una Transacción en Curso" });
      }

      const getLastTransactionId =
        "SELECT id FROM transactions ORDER BY id DESC LIMIT 1";

      db.query(getLastTransactionId, (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        const lastId = result.length > 0 ? result[0].id + 1 : 0;
        const transactionId = `TSC${String(lastId).padStart(8, "0")}`;

        db.beginTransaction((error) => {
          if (error) {
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          let receiver_id = null;
          let status = 2;
          let needsApproval = false;

          if (transaction_type === 2 && amount >= 10000) {
            status = 1;
            authorized_by = null;
            needsApproval = true;
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
                  return db.rollback(() => {
                    response
                      .status(500)
                      .json({ message: "Error Interno del Servidor" });
                  });
                }

                if (needsApproval) {
                  waitingForApproval();
                } else {
                  updateBalances();
                }
              }
            );
          }

          function waitingForApproval() {
            const approvalsCounter =
              "SELECT id FROM approvals ORDER BY id DESC LIMIT 1";

            db.query(approvalsCounter, (error, result) => {
              if (error) {
                return db.rollback(() => {
                  response
                    .status(500)
                    .json({ message: "Error Interno del Servidor" });
                });
              }

              const lastApprovalId = result.length > 0 ? result[0].id : 0;
              const approvalId = `APVL${String(lastApprovalId + 1).padStart(
                6,
                "0"
              )}`;

              const waitingForApproval =
                "INSERT INTO approvals (approval_id, transaction_id, is_approved, authorizer_id, date_hour) VALUES (?, ?, ?, ?, ?)";

              db.query(
                waitingForApproval,
                [approvalId, lastId, null, null, null],
                (error, result) => {
                  if (error) {
                    return db.rollback(() => {
                      response
                        .status(500)
                        .json({ message: "Error Interno del Servidor" });
                    });
                  }

                  db.commit((error) => {
                    if (error) {
                      return db.rollback(() => {
                        response
                          .status(500)
                          .json({ message: "Error Interno del Servidor" });
                      });
                    }

                    audit(
                      user_id,
                      "Transacción Registrada",
                      `Se Creó la Transacción ${transactionId}, de $${amount}`,
                      request
                    );

                    return response.status(200).json({
                      message: "Transacción Registrada",
                    });
                  });
                }
              );
            });
          }

          function updateBalances() {
            if (transaction_type === 1) {
              const updateBalance =
                "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
              db.query(
                updateBalance,
                [amount, receiver_account_number],
                transactionSuccess
              );
            } else if (transaction_type === 2) {
              const updateBalance =
                "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
              db.query(
                updateBalance,
                [amount, sender_account_number],
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

          function transactionSuccess(error, result) {
            if (error) {
              return db.rollback(() => {
                response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              });
            }

            db.commit((error) => {
              if (error) {
                return db.rollback(() => {
                  response
                    .status(500)
                    .json({ message: "Error Interno del Servidor" });
                });
              }

              audit(
                user_id,
                "Transacción Registrada",
                `Se Creó la Transacción ${transactionId}, de $${amount}`,
                request
              );

              return response
                .status(200)
                .json({ message: "Transacción Registrada con Éxito" });
            });
          }
        });
      });
    });
  }
};

exports.searchTransaction = (request, response) => {
  const { transaction_id, realized_by, transaction_type, date } = request.query;

  if (!transaction_id && !realized_by && !transaction_type && !date) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  let searchTransaction =
    "SELECT transactions.transaction_id as id, customers.name AS customer, customers.email AS customer_email, CONCAT('**** **** **** ', RIGHT(transactions.sender_account, 4)) AS sender_account, receivers.name AS receiver, receivers.email AS receiver_email, CONCAT('**** **** **** ', RIGHT(transactions.receiver_account, 4)) AS receiver_account, transaction_types.transaction_type, transactions.amount, transactions.concept, transactions.status, transactions.date_hour AS datetime, cashier.username as realized_by, users.username as authorized_by FROM transactions INNER JOIN customers ON customers.id = transactions.customer_id INNER JOIN customers receivers ON receivers.id = transactions.receiver_id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users cashier ON cashier.id = transactions.realized_by LEFT JOIN users ON users.id = transactions.authorized_by INNER JOIN accounts ON accounts.owner_id = customers.id WHERE accounts.deleted_at IS NULL";
  let transactionData = [];

  if (transaction_id) {
    searchTransaction += " AND transactions.transaction_id LIKE ?";
    transactionData.push([`%${transaction_id}%`]);
  }

  if (realized_by) {
    searchTransaction += " AND cashier.username LIKE ?";
    transactionData.push([`%${realized_by}%`]);
  }

  if (transaction_type) {
    searchTransaction += " AND transaction_types.id LIKE ?";
    transactionData.push([`%${transaction_type}%`]);
  }

  if (date) {
    searchTransaction += " AND transactions.date_hour LIKE ?";
    transactionData.push([`%${moment(date).format("YYYY-MM-DD")}%`]);
  }

  searchTransaction += " ORDER BY datetime DESC";

  db.query(searchTransaction, transactionData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (result.length === 0) {
      return response
        .status(404)
        .json({ message: "No Se Encontraron Resultados" });
    }

    return response.status(200).json(result);
  });
};

exports.getUserByPin = (request, response) => {
  const { pin } = request.params;
  const decryptedPin = crypto.createHash("sha256").update(pin).digest("hex");

  if (!pin) {
    return response
      .status(400)
      .json({ message: "Por Favor, Introduzca una Clave de Aprobación" });
  }

  let searchUser =
    "SELECT users.id, roles.role FROM users INNER JOIN roles ON users.role_id = roles.id WHERE users.deleted_at IS NULL AND users.pin = ?";

  db.query(searchUser, [decryptedPin], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (result.length === 0) {
      return response
        .status(404)
        .json({ message: "El Pin Introducido no Existe" });
    }

    return response.status(200).json(result);
  });
};
