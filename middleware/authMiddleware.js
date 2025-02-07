require("dotenv").config();
const jwt = require("jsonwebtoken");

const verifyUser = (request, response, next) => {
  const token = request.headers["authorization"];

  if (!token) {
    return response
      .status(404)
      .json({ mensaje: "Acceso Denegado, Token no Encontrado" });
  }

  console.log(process.env.JWT_KEY);

  try {
    const decoded = jwt.verify(token.split(" ")[1], process.env.JWT_KEY);
    request.usuario = decoded;
    next();
  } catch (error) {
    return response
      .status(401)
      .json({ mensaje: "El Token es Invalido o ha Expirado" });
  }
};

module.exports = { verifyUser };
