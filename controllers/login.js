const db = require("../config/db");
const crypto = require("crypto");
const auditActions = require("../global/audit");

exports.login = (request, response) => {
  const { username, password } = request.body;
  const hashedPassword = crypto
    .createHash("sha256")
    .update(password)
    .digest("hex");
  const loggedIn = "SELECT * FROM users WHERE username = ? AND password = ?";

  // console.log(hashedPassword);

  if (!username || !password) {
    return response
      .status(400)
      .json({ message: "Por Favor, Introduzca un Usuario y una Contraseña" });
  }

  db.query(loggedIn, [username, hashedPassword], (error, results) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (results.length === 0) {
      return response
        .status(401)
        .json({ message: "Usuario o Contraseña no Válidos" });
    }

    auditActions(
      results[0].id,
      "Inicio de Sesión",
      "Inicio de Sesión Correcto"
    );

    return response.status(200).json({
      icon: "success",
      message: "¡Inicio de Sesión Correcto!",
      isSupervisor: results[0].role === 1 ? true : false,
    });
  });
};
