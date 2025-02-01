const db = require("../config/db");

exports.getUsers = (request, response) => {
  const users =
    "SELECT id, username, email, CASE WHEN role_id = 1 THEN 'Supervisor' ELSE 'Cajero' END AS role FROM users";
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

exports.updateUser = (request, response) => {
  const { id } = request.params;
  const { username, email } = request.body;
  let { new_password } = request.body;

  const updateUser =
    "UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?";

  if (!username || !email) {
    return response
      .status(400)
      .json({ message: "Por Favor, Rellene Todos los Campos" });
  }

  const getUserPassword = "SELECT password FROM users WHERE id = ?";

  db.query(getUserPassword, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const password = result[0].password;

    if (!new_password) {
      new_password = password;
    } else {
      new_password = crypto
        .createHash("sha256")
        .update(new_password)
        .digest("hex");
    }

    db.query(
      updateUser,
      [username, email, new_password, id],
      (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        response
          .status(200)
          .json({ message: "Usuario Actualizado Correctamente" });
      }
    );
  });
};

exports.updateUserRole = (request, response) => {
  const { id } = request.params;
  const { newRole } = request.body;

  const updateUserRole = "UPDATE users SET role_id = ? WHERE id = ?";

  db.query(updateUserRole, [newRole, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    response
      .status(200)
      .json({ message: "Rol del Usuario Actualizado Correctamente" });
  });
};

exports.deleteUser = (request, response) => {
  const { id } = request.params;
};
