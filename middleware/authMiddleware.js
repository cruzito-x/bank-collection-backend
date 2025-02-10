require("dotenv").config();
const jwt = require("jsonwebtoken");

const authMiddleware = (request, response, next) => {
  const authHeader = request.headers["authorization"];

  if (!authHeader) {
    return response
      .status(403)
      .json({ message: "Acceso Denegado, Token no Encontrado" });
  }

  const token = authHeader.split(" ")[1];

  if (!token) {
    return response
      .status(403)
      .json({ message: "Acceso Denegado, Token no Encontrado" });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_KEY);
    request.user = decoded;

    next();
  } catch (error) {
    return response
      .status(401)
      .json({ message: "El Token es Invalido o ha Expirado" });
  }
};

module.exports = { authMiddleware };
