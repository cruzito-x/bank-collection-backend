const db = require("../config/db");

exports.getAllAccounts = (request, response) => {
  const accounts =
    "SELECT accounts.account_number, customers.name AS owner, accounts.balance, accounts.created_at AS datetime FROM accounts INNER JOIN customers ON customers.id = accounts.owner_id WHERE customers.deleted_at IS NULL AND accounts.deleted_at IS NULL ORDER BY customers.id";

  db.query(accounts, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    return response.status(200).json(result);
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

// exports.getBalanceByAccount = (request, response) => {
//   const { account_number } = request.params;
//   const balance =
//     "SELECT balance FROM accounts WHERE account_number = ? AND deleted_at IS NULL";

//   db.query(balance, [account_number], (error, result) => {
//     if (error) {
//       return response
//         .status(500)
//         .json({ message: "Error interno del Servidor" });
//     }

//     return response.status(200).json(result);
//   });
// };
