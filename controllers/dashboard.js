const db = require("../config/db");

exports.getTransactionsByCollector = (request, response) => {
  const transactionsByCollector = "SELECT collectors.service_name AS collector, COUNT(*) AS transactionsByCollector FROM payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id GROUP BY payments_collectors.collector_id;";
  
  db.query(transactionsByCollector, (error, result) => {
    if(error) {
      return response.status(500).json({ message: "Error Interno del Servidor"});
    }

    return response.status(200).json(result);
  });
}