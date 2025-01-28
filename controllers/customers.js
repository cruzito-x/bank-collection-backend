const db = require("../config/db");

exports.getCustomers = (request, response) => {
  const customers = "SELECT * FROM customers WHERE deleted_at IS NULL ORDER BY balance DESC";

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

      response.status(200).json({
        message: "¡Datos de Cliente Actualizados!",
      });
    }
  );
};

exports.deleteCustomer = (request, response) => {
  const { id } = request.params;
  const deleteCustomer = "UPDATE customers SET deleted_at = now() WHERE id = ?";

  db.query(deleteCustomer, [id], (error, results) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json({
      message: "¡Cliente Eliminado!",
    });
  });
};

exports.searchCustomer = (request, response) => {
  const { name = "", identity_doc = "", balance } = request.query;
  let ORDER_BY = balance == 0 ? "DESC" : "ASC";

  const searchCustomer = `SELECT * FROM customers WHERE deleted_at IS NULL AND (name LIKE ? OR identity_doc LIKE ?) ORDER BY balance ${ORDER_BY}`;
  const customerData = [name, identity_doc];

  db.query(searchCustomer, customerData, (error, results) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(results);
  });
};
