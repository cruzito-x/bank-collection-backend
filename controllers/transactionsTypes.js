const db = require("../config/db");

exports.getTypes = (request, response) => {
  const types =
    "SELECT id, transaction_type FROM transaction_types WHERE deleted_at IS NULL";

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

exports.updateTransactionType = (request, response) => {
  const { id } = request.params;
  const { transactionType } = request.body;

  const updateTransactionType =
    "UPDATE transaction_types SET transaction_type = ? WHERE id = ?";

  db.query(updateTransactionType, [transactionType, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json({
      message: "Tipo de Transacción Actualizado Correctamente",
    });
  });
};

exports.deleteTransactionType = (request, response) => {
  const { id } = request.params;

  const deleteTransactionType =
    "UPDATE transaction_types SET deleted_at = ? WHERE id = ?";

  db.query(deleteTransactionType, [new Date(), id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json({
      message: "Tipo de Transacción Eliminado Correctamente",
    });
  });
};
