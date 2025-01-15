const db = require("../config/db");

exports.getCustomers = (request, response) => {
  const customers = "SELECT * FROM customers";

  db.query(customers, (error, results) => {
    if(error) {
      return response
       .status(500)
       .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(results);
  })
}