const db = require("../config/db");

exports.getAudits = (request, response) => {
  const audits =
    "SELECT users.username, audit.action, audit.date_hour as datetime, audit.detail as details FROM audit INNER JOIN users ON users.id = audit.user_id ORDER BY datetime DESC;";

  db.query(audits, (error, result) => {
    if (error) {
      response.status(500).json({
        message: "Error Interno del Servidor",
      });
    }

    response.status(200).json(result);
  });
};
