const db = require("../config/db");

exports.getCustomers = (request, response) => {
  const customers = "SELECT customers.*, accounts.account_number, accounts.balance FROM customers INNER JOIN accounts ON accounts.owner_id = customers.id WHERE customers.deleted_at IS NULL AND accounts.deleted_at IS NULL ORDER BY accounts.balance DESC";

  db.query(customers, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(result);
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
    (error, result) => {
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

  db.query(deleteCustomer, [id], (error, result) => {
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

  const searchCustomer = `SELECT customers.* FROM customers INNER JOIN accounts ON accounts.owner_id = customers.id WHERE deleted_at IS NULL AND (name LIKE ? OR identity_doc LIKE ?) ORDER BY accounts.balance ${ORDER_BY}`;
  const customerData = [name, identity_doc];

  db.query(searchCustomer, customerData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(result);
  });
};
