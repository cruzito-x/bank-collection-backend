const db = require("../config/db");
const audit = require("../global/audit/audit");

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
  const user_id = request.headers["user_id"];
  const { transactionType } = request.body;
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
    const newTransactionType =
      "INSERT INTO transaction_types (transaction_type_id, transaction_type) VALUES (?, ?)";

    db.query(
      newTransactionType,
      [transactionTypeId, transactionType],
      (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        audit(
          user_id,
          "Nuevo Tipo de Transacción Registrado",
          `${transactionType} Registrado`,
          request
        );

        return response.status(200).json({
          message: "¡Nuevo Tipo de Transacción Registrado Exitosamente!",
        });
      }
    );
  });
};

exports.updateTransactionType = (request, response) => {
  const user_id = request.headers["user_id"];
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

    audit(
      user_id,
      "Tipo de Transacción Actualizado",
      `Se Actualizó el Nombre del Tipo de Transacción con Código ${id}`,
      request
    );

    return response.status(200).json({
      message: "¡Tipo de Transacción Actualizado Exitosamente!",
    });
  });
};

exports.deleteTransactionType = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;

  const deleteTransactionType =
    "UPDATE transaction_types SET deleted_at = ? WHERE id = ?";

  db.query(deleteTransactionType, [new Date(), id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const deletedTransactionTypeName =
      "SELECT transaction_type FROM transaction_types WHERE id =?";

    db.query(deletedTransactionTypeName, [id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      audit(
        user_id,
        "Tipo de Transacción Eliminado",
        `Se Eliminó el Tipo de Transacción ${result[0].transaction_type}`,
        request
      );
    });

    return response.status(200).json({
      message: "¡Tipo de Transacción Eliminado Exitosamente!",
    });
  });
};

exports.searchTransactionType = (request, response) => {
  const { transaction_type } = request.query;

  if (!transaction_type) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  const searchTransactionType =
    "SELECT * FROM transaction_types WHERE transaction_type LIKE ? AND deleted_at IS NULL";

  db.query(
    searchTransactionType,
    [`%${transaction_type}%`],
    (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      if (result.length === 0) {
        return response
          .status(404)
          .json({ message: "No Se Encontraron Resultados" });
      }

      return response.status(200).json(result);
    }
  );
};
