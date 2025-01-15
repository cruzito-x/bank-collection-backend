const db = require("../config/db");

exports.getUsers = (request, response) => {
  const users =
    "SELECT username, email, CASE WHEN role_id = 1 THEN 'Supervisor' ELSE 'Cajero' END AS role FROM users";
  db.query(users, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    response.status(200).json(result);
  });
};

exports.getUsersRoles = (request, response) => {
  const roles = "SELECT id as value, role as label FROM roles";

  db.query(roles, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    response.status(200).json(result);
  });
};
