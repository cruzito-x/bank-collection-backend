const db = require("../config/db");

exports.getServices = (request, response) => {
  const services = "SELECT * FROM services";

  db.query(services, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getServicesByCollector = (request, response) => {
  const { collector_id } = request.params;
  const servicesByCollector = "SELECT * FROM services WHERE collector_id = ?";

  db.query(servicesByCollector, [collector_id], (error, result) => {
    if(error) {
      return response.status(500).json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};
