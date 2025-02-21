const db = require("../config/db");
const audit = require("../global/audit/audit");
const crypto = require("crypto");

exports.getUsers = (request, response) => {
  const users =
    "SELECT id, username, email, CASE WHEN role_id = 1 THEN 'Supervisor' ELSE 'Cajero' END AS role FROM users WHERE deleted_at IS NULL";
  db.query(users, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getUsersRoles = (request, response) => {
  const roles = "SELECT id AS value, role AS label FROM roles";

  db.query(roles, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.updateUser = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const { username, email } = request.body;
  let { new_password } = request.body;

  if (user_id === id) {
    return response
      .status(400)
      .json({ message: "No Puedes Modificar Tu Propio Usuario" });
  }

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
    } else if (new_password.length < 6) {
      return response
        .status(400)
        .json({ message: "La Contraseña Debe Tener Al Menos 6 Caracteres" });
    } else {
      new_password = crypto
        .createHash("sha256")
        .update(new_password)
        .digest("hex");
    }

    const getUsername =
      "SELECT username FROM users WHERE username = ? AND id != ? AND deleted_at IS NULL";
    db.query(getUsername, [username, id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      if (result.length > 0) {
        return response
          .status(409)
          .json({ message: "Este Nombre de Usuario ya Está Registrado" });
      }

      const updateUser =
        "UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?";

      db.query(
        updateUser,
        [username, email, new_password, id],
        (error, result) => {
          if (error) {
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          audit(
            user_id,
            "Usuario Actualizado",
            `Se Actualizaron los Datos del Usuario ${username}`,
            request
          );

          return response
            .status(200)
            .json({ message: "Usuario Actualizado con Éxito" });
        }
      );
    });
  });
};

exports.updateUserRole = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const { newRole } = request.body;

  if (user_id === id) {
    return response
      .status(400)
      .json({ message: "No Puede Asignar el Rol al Usuario Activo" });
  }

  const updateUserRole = "UPDATE users SET role_id = ? WHERE id = ?";

  db.query(updateUserRole, [newRole, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const getUsername =
      "SELECT users.username, roles.role FROM users INNER JOIN roles ON roles.id = users.role_id WHERE users.id = ?";

    db.query(getUsername, [id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const username = result[0].username;
      const role = result[0].role;

      audit(
        user_id,
        "Asignación de Nuevo Rol",
        `Se Asignó el Rol ${role} al Usuario ${username}`,
        request
      );
    });

    return response
      .status(200)
      .json({ message: "El Rol del Usuario ha Sido Actualizado con Éxito" });
  });
};

exports.deleteUser = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;

  const deleteUser = "UPDATE users SET deleted_at = ? WHERE id = ?";

  db.query(deleteUser, [new Date(), id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const getUsername = "SELECT username FROM users WHERE id = ?";

    db.query(getUsername, [id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const username = result[0].username;

      audit(
        user_id,
        "Usuario Eliminado",
        `Se Eliminó el Usuario ${username}`,
        request
      );
    });

    return response
      .status(200)
      .json({ message: "Usuario Eliminado con Éxito" });
  });
};

exports.searchUser = (request, response) => {
  const { username, role } = request.query;

  if (!username && !role) {
    return response.status(400).json({
      message: "Por Favor, Proporcione un Nombre o un Rol",
    });
  }

  let searchUser =
    "SELECT id, username, email, CASE WHEN role_id = 1 THEN 'Supervisor' ELSE 'Cajero' END AS role FROM users WHERE deleted_at IS NULL";
  let userData = [];

  if (username) {
    searchUser += " AND username LIKE ?";
    userData.push(`%${username}%`);
  }

  if (role) {
    searchUser += " AND role_id = ?";
    userData.push(role);
  }

  db.query(searchUser, userData, (error, result) => {
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
  });
};
