const db = require("../config/db");

exports.getTransactions = (request, response) => {
  const transactions = "SELECT * FROM transactions";

  db.query(transactions, (error, result) => {
    if(error) {
      return response.status(500).json({ icon: "error", message: "Error Interno del Servidor"});
    }

    return response.status(200).json(result);
  });
};
