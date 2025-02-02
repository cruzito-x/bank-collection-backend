const db = require("../config/db");
const audit = require("../global/audit/audit");

exports.getCustomers = (request, response) => {
  const customers = "SELECT * FROM customers WHERE deleted_at IS NULL";

  db.query(customers, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    response.status(200).json(result);
  });
};

exports.getAccountsByCustomer = (request, response) => {
  const { id } = request.params;
  const accounts =
    "SELECT accounts.account_number, customers.name AS owner, accounts.balance, accounts.created_at AS datetime FROM accounts INNER JOIN customers ON customers.id = accounts.owner_id WHERE customers.id = ? AND customers.deleted_at IS NULL AND accounts.deleted_at IS NULL ORDER BY customers.id";

  db.query(accounts, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.updateCustomer = (request, response) => {
  const user_id = 1;
  const { id } = request.params;
  const { name, identity_doc, email } = request.body;
  const updateCustomer =
    "UPDATE customers SET name = ?, email = ? WHERE id = ?";

  db.query(updateCustomer, [name, email, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    audit(
      user_id,
      "Cliente Actualizado",
      `Se Actualizaron los Datos del Cliente con Número de Identidad ${identity_doc}`
    );

    response.status(200).json({
      message: "¡Datos de Cliente Actualizados!",
    });
  });
};

exports.deleteCustomer = (request, response) => {
  const user_id = 1;
  const { id } = request.params;
  const deleteCustomer = "UPDATE customers SET deleted_at = now() WHERE id = ?";

  db.query(deleteCustomer, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    const getCustomerById = "SELECT identity_doc FROM customers WHERE id = ?";

    db.query(getCustomerById, [id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error interno del Servidor" });
      }

      audit(
        user_id,
        "Cliente Eliminado",
        `Se Eliminó al Cliente con Número de Identidad ${result[0].identity_doc}`
      );
    });

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
