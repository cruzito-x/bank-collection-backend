const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");

exports.getCollectors = (request, response) => {
  const collectors =
    "SELECT collectors.id, collectors.service_name AS collector, services.service_name, services.description FROM collectors INNER JOIN services ON services.collector_id = collectors.id ORDER BY collectors.service_name ASC";

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
  const {
    collector_name,
    collector_description,
    service_name,
    service_description,
  } = request.body;

  if (
    !collector_name ||
    !collector_description ||
    !service_name ||
    !service_description
  ) {
    return response.status(400).json({
      message: "Por Favor, Rellene Todos los Campos",
    });
  }

  const getCollectorCounter =
    "SELECT COUNT(*) AS collectorsCounter FROM collectors";
  const getServiceCounter = "SELECT COUNT(*) AS servicesCounter FROM services";

  db.beginTransaction((error) => {
    if (error) {
      return db.rollback(() => {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      });
    }

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
        [collector_id, collector_name, collector_description],
        (error, result) => {
          if (error) {
            return db.rollback(() => {
              return response.status(500).json({
                message: "Error Interno del Servidor",
              });
            });
          }

          db.query(getServiceCounter, (error, result) => {
            if (error) {
              return db.rollback(() => {
                return response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              });
            }

            const serviceCounter = result[0].servicesCounter;
            const service_id = crypto
              .createHash("sha256")
              .update((serviceCounter + 1).toString())
              .digest("hex");

            const newService =
              "INSERT INTO services (service_id, collector_id, service_name, description, price) VALUES (?, ?, ?, ?, ?)";

            db.query(
              newService,
              [
                service_id,
                collectorCounter + 1,
                service_name,
                service_description,
                0,
              ],
              (error, result) => {
                if (error) {
                  return db.rollback(() => {
                    return response.status(500).json({
                      message: "Error Interno del Servidor",
                    });
                  });
                }

                db.commit((error) => {
                  if (error) {
                    return db.rollback(() => {
                      return response
                        .status(500)
                        .json({ message: "Error Interno del Servidor" });
                    });
                  }
                });

                audit(1, "Añadir Colector", "Adición de Nuevo Colector");

                return response.status(200).json({
                  message: "¡Colector Añadido Exitosamente!",
                });
              }
            );
          });
        }
      );
    });
  });
};
