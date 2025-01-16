const db = require("../config/db");

function audit(user_id, action, detail) {
  const audit =
    "INSERT INTO audit (user_id, action, date_hour, detail) VALUES (?, ?, now(), ?)";

  db.query(audit, [user_id, action, detail], (error, result) => {
    if (error) {
      console.error("Error al auditar acción:", error);
      return;
    }
  });
}

module.exports = audit;
