const db = require("../config/db");

exports.getTransactions = (request, response) => {
  const transactions =
    "SELECT transactions.id, customers.name as customer, transaction_types.transaction_type, transactions.amount, transactions.date_hour as datetime, users.username as authorized_by FROM transactions INNER JOIN customers ON transactions.customer_id = customers.id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users ON users.user_id = transactions.authorized_by ORDER BY transactions.date_hour DESC";

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
    "SELECT transactions.id, customers.name AS customer, receiver.name AS receiver, transaction_types.transaction_type, transactions.amount, transactions.date_hour AS datetime, users.username AS authorized_by FROM transactions LEFT JOIN customers ON transactions.customer_id = customers.id LEFT JOIN customers AS receiver ON transactions.receiver_id = receiver.id LEFT JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id LEFT JOIN users ON users.id = transactions.authorized_by WHERE transactions.customer_id = ? ORDER BY transactions.date_hour DESC";

  db.query(transactionsByCustomer, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};
