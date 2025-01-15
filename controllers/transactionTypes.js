const db = require("../config/db");

exports.getTypes = (request, response) => {
  const types = "SELECT id, transaction_type FROM transaction_types";

  db.query(types, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.saveNewType = (request, response) => {
  const { transaction_id, transaction_type } = request.body;
  const newType =
    "INSERT INTO transaction_types (transaction_id, transaction_type) VALUES (?, ?)";

  db.query(newType, [transaction_id, transaction_type], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (!transaction_id || !transaction_type) {
      return response
        .status(400)
        .json({
          icon: "success",
          message: "Por Favor, Introduzca Información",
        });
    }

    return response
      .status(200)
      .json({
        icon: "success",
        message: "Nuevo Tipo de Transacción Guardado Correctamente",
      });
  });
};
