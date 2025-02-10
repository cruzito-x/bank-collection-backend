const db = require("../../config/db");
const clientIP = require("get-client-ip");

function audit(user_id, action, details) {
  const audit =
    "INSERT INTO audit (user_id, action, details, client_details, date_hour) VALUES (?, ?, ?, ?, ?)";

  db.query(
    audit,
    [user_id, action, details, clientIP(request), new Date()],
    (error, result) => {
      if (error) {
        console.error(error);
        return;
      }
    }
  );
}

module.exports = audit;
