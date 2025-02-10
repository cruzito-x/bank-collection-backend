const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");

exports.getCollectors = (request, response) => {
  const collectors =
    "SELECT collectors.id, collectors.collector, collectors.description, GROUP_CONCAT(services.service_name ORDER BY services.service_name ASC SEPARATOR ', ') AS services_names FROM collectors INNER JOIN services ON services.collector_id = collectors.id WHERE collectors.deleted_at IS NULL AND services.deleted_at IS NULL GROUP BY collectors.id, collectors.collector ORDER BY collectors.collector ASC";

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
  const user_id = request.headers["user_id"];
  const {
    collector_name,
    collector_description,
    service_name,
    service_description,
    price,
  } = request.body;

  if (
    !collector_name ||
    !collector_description ||
    !service_name ||
    !service_description ||
    !price
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

    const getLastCollectorId =
      "SELECT id FROM collectors ORDER BY id DESC LIMIT 1";

    db.query(getLastCollectorId, (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const latestCollectorId = result.length > 0 ? result[0].id + 1 : 0;
      const collector_id = `CLT${String(latestCollectorId).padStart(8, "0")}`;

      const newCollector =
        "INSERT INTO collectors (collector_id, collector, description) VALUES (?, ?, ?)";

      db.query(
        newCollector,
        [collector_id, collector_name, collector_description],
        (error, result) => {
          if (error) {
            return db.rollback(() => {
              return response
                .status(500)
                .json({ message: "Error Interno del Servidor" });
            });
          }

          const getLastServiceId =
            "SELECT id FROM services ORDER BY id DESC LIMIT 1";

          db.query(getLastServiceId, (error, result) => {
            if (error) {
              return db.rollback(() => {
                return response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              });
            }

            const latestServiceId = result.length > 0 ? result[0].id + 1 : 0;
            const service_id = `SRV${String(latestServiceId).padStart(8, "0")}`;

            const saveNewService =
              "INSERT INTO services (service_id, collector_id, service_name, description, price) VALUES (?, ?, ?, ?, ?)";

            db.query(
              saveNewService,
              [
                service_id,
                latestCollectorId,
                service_name,
                service_description,
                price,
              ],
              (error, result) => {
                if (error) {
                  return db.rollback(() => {
                    return response
                      .status(500)
                      .json({ message: "Error Interno del Servidor" });
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
                  `Se Registró al Colector ${collector_name}`,
                  request
                );

                audit(
                  user_id,
                  "Servicio Registrado",
                  `Se Registró el Servicio ${service_name} del Colector ${collector_name}`,
                  request
                );

                return response.status(200).json({
                  message: "Colector Registrado con Éxito",
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
    "SELECT payments_collectors.id, collectors.collector, COALESCE(services.service_name, 'Desconocido') AS service, payments_collectors.amount, customers.name AS payed_by, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN collectors ON payments_collectors.collector_id = collectors.id INNER JOIN customers ON customers.id = payments_collectors.customer_id LEFT JOIN services ON payments_collectors.service_id = services.id INNER JOIN users ON users.id = payments_collectors.registered_by WHERE collectors.id = ? ORDER BY datetime DESC";

  db.query(viewPaymentsCollectorDetails, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.updateCollector = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const { collector, description } = request.body;

  if (!collector || !description) {
    return response.status(400).json({
      message: "Por Favor, Rellene Todos los Campos",
    });
  }

  const updateCollector =
    "UPDATE collectors SET collector = ?, description = ? WHERE id = ?";

  db.query(updateCollector, [collector, description, id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    audit(
      user_id,
      "Colector Modificado",
      `Se Modificó el Colector ${collector}`,
      request
    );

    return response.status(200).json({
      message: "Datos del Colector Actualizados con Éxito",
    });
  });
};

exports.deleteCollector = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const deleteCollector = "UPDATE collectors SET deleted_at = ? WHERE id = ?";

  db.query(deleteCollector, [new Date(), id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const deleteCollectorServices =
      "UPDATE services SET deleted_at = ? WHERE collector_id = ?";

    db.query(deleteCollectorServices, [new Date(), id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const getCollectorName = "SELECT collector FROM collectors WHERE id = ?";

      db.query(getCollectorName, [id], (error, results) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        audit(
          user_id,
          "Colector Eliminado",
          `Se Eliminó Tanto al Colector ${results[0].collector} Como a sus Servicios`,
          request
        );
      });
    });

    return response
      .status(200)
      .json({ message: "Colector Eliminado con Éxito" });
  });
};

exports.searchCollector = (request, response) => {
  const { collector } = request.query;

  if (!collector) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  const searchCollector =
    "SELECT collectors.id, collectors.collector, collectors.description, GROUP_CONCAT(services.service_name ORDER BY services.service_name ASC SEPARATOR ', ') AS services_names FROM collectors INNER JOIN services ON services.collector_id = collectors.id WHERE collectors.collector LIKE ? AND collectors.deleted_at IS NULL AND services.deleted_at IS NULL GROUP BY collectors.id, collectors.collector ORDER BY collectors.collector ASC";

  db.query(searchCollector, [`%${collector}%`], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (result.length === 0) {
      return response
        .status(404)
        .json({ message: "No Se Encontraron Resultados" });
    }

    return response.status(200).json(result);
  });
};
