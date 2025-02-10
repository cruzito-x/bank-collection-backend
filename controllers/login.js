const db = require("../config/db");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const audit = require("../global/audit/audit");

exports.login = (request, response) => {
  const { username, password } = request.body;

  const hashedPassword = crypto
    .createHash("sha256")
    .update(password)
    .digest("hex");
  const loggedIn = "SELECT * FROM users WHERE username = ? AND password = ?";

  if (!username || !password) {
    return response
      .status(400)
      .json({ message: "Por Favor, Introduzca un Usuario y una Contraseña" });
  }

  db.query(loggedIn, [username, hashedPassword], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (result.length === 0) {
      return response
        .status(401)
        .json({ message: "Usuario o Contraseña no Válidos" });
    }

    audit(
      result[0].id,
      "Inicio de Sesión",
      "Inicio de Sesión Correcto",
      request
    );

    const token = jwt.sign(
      { id: result[0].id, username: result[0].username },
      process.env.JWT_KEY,
      { expiresIn: "8h" }
    );

    return response.status(200).json({
      message: "Inicio de Sesión Correcto",
      token,
      user_id: result[0].id,
      username: result[0].username,
      isSupervisor: result[0].role_id === 1 ? true : false,
    });
  });
};

exports.logout = (request, response) => {
  const { id } = request.params;
  const loggedOut = "SELECT * FROM users WHERE id = ?";

  db.query(loggedOut, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    audit(id, "Cierre de Sesión", "Cierre de Sesión Correcto", request);
    return response.status(200).json({ message: "Cierre de Sesión Correcto" });
  });
};
