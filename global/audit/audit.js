const db = require("../../config/db");
const getClientIP = require("get-client-ip");
const useragent = require("useragent");

function audit(user_id, action, details, request) {
  const clientIp = getClientIP(request);
  const agent = useragent.parse(request.headers["user-agent"]);
  const clientDetails = `Desde: ${agent.toAgent()}; OS: ${agent.os.toString()}; IP: ${clientIp}`;

  const audit =
    "INSERT INTO audit (user_id, action, details, client_details, date_hour) VALUES (?, ?, ?, ?, ?)";

  db.query(
    audit,
    [user_id, action, details, clientDetails, new Date()],
    (error, result) => {
      if (error) {
        return;
      }
    }
  );
}

module.exports = audit;
