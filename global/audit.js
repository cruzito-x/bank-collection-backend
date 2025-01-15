const db = require("../config/db");

function auditActions(user_id, action, detail) {
  const auditQuery =
    "INSERT INTO audit (user_id, action, date_hour, detail) VALUES (?, ?, now(), ?)";

  db.query(
    auditQuery,
    [user_id, action, detail],
    (error, result) => {
      if (error) {
        console.error("Error al auditar acción:", error);
        return;
      }
    }
  );
}

module.exports = auditActions;
