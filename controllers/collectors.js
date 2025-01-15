const db = require("../config/db");
const crypto = require("crypto");

exports.getCollectors = (request, response) => {
  const collectors = "SELECT * FROM collectors";

  db.query(collectors, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.saveNewCollector = (request, response) => {
  const { service_name, description } = request.body;

  if (!service_name || !description) {
    console.log("El Nombre del Servicio y la Descripción Son Requeridos")
    return response
      .status(400)
      .json({
        icon: "error",
        message: "El Nombre del Servicio y la Descripción Son Requeridos",
      });
  }

  const getCollectorCounter = "SELECT COUNT(*) as collectorsCounter FROM collectors";

  db.query(getCollectorCounter, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const collectorCounter = result[0].collectorsCounter;
    const collector_id = crypto
      .createHash("sha256")
      .update((collectorCounter + 1).toString())
      .digest("hex");

    const newCollector =
      "INSERT INTO collectors (collector_id, service_name, description) VALUES (?, ?, ?)";

    db.query(
      newCollector,
      [collector_id, service_name, description],
      (error, result) => {
        if (error) {
          return response.status(500).json({
            icon: "error",
            message: "Error Interno del Servidor",
          });
        }

        return response.status(200).json({
          icon: "success",
          message: "¡Colector Añadido Exitosamente!",
        });
      }
    );
  });
};
