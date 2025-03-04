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

    return response.status(200).json(result);
  });
};

exports.updateCustomer = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const { name, identity_doc, email } = request.body;

  if (!name || !identity_doc || !email) {
    return response.status(400).json({
      message: "Por Favor, Rellene Todos los Campos",
    });
  }

  const getCustomerEmail =
    "SELECT id FROM customers WHERE email = ? AND id != ?";

  db.query(getCustomerEmail, [email, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    if (result.length > 0) {
      return response
        .status(409)
        .json({ message: "El Email ya Está en uso Por Otro Cliente" });
    }

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
        `Se Actualizaron los Datos del Cliente con Número de Identidad ${identity_doc}`,
        request
      );

      return response.status(200).json({
        message: "Datos del Cliente Actualizados con Éxito",
      });
    });
  });
};

exports.deleteCustomer = (request, response) => {
  const user_id = request.headers["user_id"];
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
        `Se Eliminó al Cliente con Número de Identidad ${result[0].identity_doc}`,
        request
      );
    });

    return response.status(200).json({
      message: "Cliente Eliminado con Éxito",
    });
  });
};

exports.searchCustomer = (request, response) => {
  const { name, identity_doc } = request.query;

  if (!name && !identity_doc) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  let searchCustomer = "SELECT * FROM customers WHERE deleted_at IS NULL";
  let customerData = [];

  if (name && !identity_doc) {
    searchCustomer += " AND name LIKE ?";
    customerData.push(`%${name}%`);
  }

  if (!name && identity_doc) {
    searchCustomer += " AND identity_doc LIKE ?";
    customerData.push(`%${identity_doc}%`);
  }

  if (name && identity_doc) {
    searchCustomer += " AND (name LIKE ? OR identity_doc LIKE ?)";
    customerData.push(`%${name}%`);
    customerData.push(`%${identity_doc}%`);
  }

  searchCustomer += " ORDER BY id DESC";

  db.query(searchCustomer, customerData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    if (result.length === 0) {
      return response
        .status(404)
        .json({ message: "No Se Encontraron Resultados" });
    }

    return response.status(200).json(result);
  });
};
