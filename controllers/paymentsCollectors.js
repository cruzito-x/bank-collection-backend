const db = require("../config/db");

exports.getCollectorsPayments = (request, response) => {
  const paymentsCollectors = "SELECT * FROM payments_collectors";

  db.query(paymentsCollectors, (error, result) => {
    if(error) {
      return response.status(500).json({ icon: "error", message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
}