const db = require("../config/db");
const moment = require("moment");

exports.getAudits = (request, response) => {
  const audits =
    "SELECT users.username, audit.action, audit.date_hour AS datetime, audit.details FROM audit INNER JOIN users ON users.id = audit.user_id ORDER BY datetime DESC";

  db.query(audits, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.searchAudit = (request, response) => {
  const { username, date } = request.query;

  if (!username && !date) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  let searchAudits =
    "SELECT users.username, audit.action, audit.date_hour AS datetime, audit.details FROM audit INNER JOIN users ON users.id = audit.user_id WHERE audit.date_hour IS NOT NULL";
  let auditData = [];

  if (username) {
    searchAudits += " AND users.username LIKE ?";
    auditData.push(`%${username}%`);
  }

  if (date) {
    searchAudits += " AND DATE(audit.date_hour) = ?";
    auditData.push(moment(date).format("YYYY-MM-DD"));
  }

  searchAudits += " ORDER BY audit.date_hour DESC";

  db.query(searchAudits, auditData, (error, result) => {
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
