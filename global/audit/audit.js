const db = require("../../config/db");

function audit(user_id, action, details, client_details) {
  const audit =
    "INSERT INTO audit (user_id, action, details, client_details, date_hour) VALUES (?, ?, ?, ?, ?)";

  db.query(
    audit,
    [user_id, action, details, client_details, new Date()],
    (error, result) => {
      if (error) {
        console.error(error);
        return;
      }
    }
  );
}

module.exports = audit;
