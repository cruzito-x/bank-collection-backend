const db = require("../config/db");

exports.getCustomers = (request, response) => {
  const customers = "SELECT * FROM customers";

  db.query(customers, (error, results) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(results);
  });
};

exports.updateCustomer = (request, response) => {
  const { id } = request.params;
  const { name, identity_doc, email } = request.body;
  const updateCustomer =
    "UPDATE customers SET name = ?, identity_doc = ?, email = ? WHERE id = ?";

  db.query(
    updateCustomer,
    [name, identity_doc, email, id],
    (error, results) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error interno del Servidor" });
      }

      response
        .status(200)
        .json({
          message: "¡Datos de Cliente Actualizados Satisfactoriamente!",
        });
    }
  );
};
