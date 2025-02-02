const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");

exports.getCollectors = (request, response) => {
  const collectors =
    "SELECT collectors.id, collectors.service_name AS collector, collectors.description, GROUP_CONCAT(services.service_name ORDER BY services.service_name ASC SEPARATOR ', ') AS services_names FROM collectors INNER JOIN services ON services.collector_id = collectors.id GROUP BY collectors.id, collectors.service_name ORDER BY collectors.service_name ASC";

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
  const user_id = 1;
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

  db.beginTransaction((error) => {
    if (error) {
      return db.rollback(() => {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      });
    }

    const getCollectorCounter =
      "SELECT COUNT(*) AS collectorsCounter FROM collectors";

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

          const getServiceCounter =
            "SELECT COUNT(*) AS servicesCounter FROM services";

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

                audit(
                  user_id,
                  "Colector Registrado",
                  `Se Registró al Colector ${collector_name}`
                );

                audit(
                  user_id,
                  "Servicio Registrado",
                  `Se Registró el Servicio ${service_name} del Colector ${collector_name}`
                );

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

exports.viewPaymentsCollectorDetails = (request, response) => {
  const { id } = request.params;
  const viewPaymentsCollectorDetails =
    "SELECT payments_collectors.id, collectors.service_name AS collector, COALESCE(services.service_name, 'Desconocido') AS service, payments_collectors.amount, customers.name AS payed_by, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN collectors ON payments_collectors.collector_id = collectors.id INNER JOIN customers ON customers.id = payments_collectors.customer_id LEFT JOIN services ON payments_collectors.service_id = services.id INNER JOIN users ON users.id = payments_collectors.registered_by WHERE collectors.id = ? ORDER BY datetime DESC";

  db.query(viewPaymentsCollectorDetails, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};
