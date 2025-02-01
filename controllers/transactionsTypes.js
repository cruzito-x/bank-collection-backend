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

exports.saveNewTransactionType = (request, response) => {
  const { transactionType } = request.body;
  const newTransactionType =
    "INSERT INTO transaction_types (transaction_type_id, transaction_type) VALUES (?, ?)";
  const getTotalTransactionTypes =
    "SELECT COUNT(*) AS transactionTypesCounter FROM transaction_types";

  if (!transactionType) {
    return response.status(400).json({
      message: "Por Favor, Rellene Todos los Campos",
    });
  }

  db.query(getTotalTransactionTypes, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const transactionTypeId = result[0].transactionTypesCounter + 1;

    db.query(
      newTransactionType,
      [transactionTypeId, transactionType],
      (error, result) => {
        console.error("2. ", error);
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        return response.status(200).json({
          message: "Nuevo Tipo de Transacción Guardado Correctamente",
        });
      }
    );
  });
};
