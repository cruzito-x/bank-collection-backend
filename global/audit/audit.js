const db = require("../../config/db");

function audit(user_id, action, details) {
  const audit =
    "INSERT INTO audit (user_id, action, date_hour, details) VALUES (?, ?, ?, ?)";

  db.query(audit, [user_id, action, new Date(), details], (error, result) => {
    if (error) {
      console.error(error);
      return;
    }
  });
}

module.exports = audit;
