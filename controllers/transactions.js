const db = require("../config/db");

exports.getTransactions = (request, response) => {
  const transactions =
    "SELECT transactions.id, customers.name as customer, transaction_types.transaction_type, transactions.amount, transactions.date_hour as datetime, users.username as authorized_by FROM transactions INNER JOIN customers ON transactions.customer_id = customers.id INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id INNER JOIN users ON users.user_id = transactions.authorized_by";

  db.query(transactions, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};
