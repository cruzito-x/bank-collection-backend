const db = require("../config/db");

exports.getCollectors = (request, response) => {
  const collectors = "SELECT * FROM collectors";

  db.query(collectors, (error, result) => {
    if(error) {
      return response.status(500).json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  })
};