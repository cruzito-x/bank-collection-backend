const db = require("../config/db");
const audit = require("../global/audit/audit");

exports.getServices = (request, response) => {
  const services =
    "SELECT services.*, services.service_name AS service, collectors.collector FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE services.deleted_at IS NULL";

  db.query(services, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.saveNewService = (request, response) => {
  const user_id = 1;
  const { collector, service, description, price } = request.body;

  const getLastServiceId = "SELECT id FROM services ORDER BY id DESC LIMIT 1";

  db.query(getLastServiceId, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const latestId = result.length > 0 ? result[0].id + 1 : 0;
    const service_id = `SRV${String(latestId).padStart(6, "0")}`;

    const saveNewService =
      "INSERT INTO services (service_id, collector_id, service_name, description, price) VALUES (?, ?, ?, ?, ?)";

    db.query(
      saveNewService,
      [service_id, collector, service, description, price],
      (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error al guardar el servicio" });
        }

        const getCollectorName =
          "SELECT collector FROM collectors WHERE id = ?";

        db.query(getCollectorName, [collector], (error, result) => {
          if (error) {
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          const collectorName = result[0].collector;

          audit(
            user_id,
            "Servicio Registrado",
            `Se Registró el Servicio ${service} Para el Colector ${collectorName} Desde la Vista Servicios`
          );
        });

        response
          .status(200)
          .json({ message: "¡Servicio Registrado Exitosamente!" });
      }
    );
  });
};

exports.getServicesByCollector = (request, response) => {
  const { collector_id } = request.params;
  const servicesByCollector = "SELECT * FROM services WHERE collector_id = ?";

  db.query(servicesByCollector, [collector_id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.viewPaymentsByServiceDetails = (request, response) => {
  const { id } = request.params;
  const viewPaymentsByServiceDetails =
    "SELECT services.service_name AS service, collectors.collector, payments_collectors.amount, customers.name AS payed_by, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN services ON services.id = payments_collectors.service_id INNER JOIN collectors ON collectors.id = payments_collectors.collector_id INNER JOIN customers ON customers.id = payments_collectors.customer_id INNER JOIN users ON users.id = payments_collectors.registered_by WHERE services.id = ? ORDER BY datetime DESC";

  db.query(viewPaymentsByServiceDetails, [id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.updateService = (request, response) => {
  user_id = 1;
  const { id } = request.params;
  const { collector, service, description, price } = request.body;

  const updateService =
    "UPDATE services SET service_name = ?, description = ?, price = ? WHERE id = ?";

  db.query(
    updateService,
    [service, description, price, id],
    (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      audit(
        user_id,
        "Servicio Actualizado",
        `Se Actualizó el Servicio ${service} del Colector ${collector}`
      );

      return response.status(200).json({
        message: "¡Servicio Actualizado Exitosamente!",
      });
    }
  );
};

exports.deleteService = (request, response) => {
  const user_id = 1;
  const { id } = request.params;

  const deleteService = "UPDATE services SET deleted_at = ? WHERE id = ?";
  db.query(deleteService, [new Date(), id], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const getServiceName =
      "SELECT collectors.collector, services.service_name AS service FROM services INNER JOIN collectors ON services.collector_id = collectors.id WHERE services.id = ?";

    db.query(getServiceName, [id], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const collector = result[0].collector;
      const service = result[0].service;

      audit(
        user_id,
        "Servicio Eliminado",
        `Se Eliminó el Servicio ${service} del Colector ${collector}`
      );

      return response
        .status(200)
        .json({ message: "¡Servicio Eliminado Exitosamente!" });
    });
  });
};

exports.searchService = (request, response) => {
  const { collector, service } = request.query;

  if (!collector && !service) {
    return response.status(400).json({
      message:
        "Por Favor, Introduzca un Nombre de Colector o un Nombre de Servicio",
    });
  }

  let searchService =
    "SELECT services.*, services.service_name AS service, collectors.collector FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE services.deleted_at IS NULL";
  let serviceData = [];

  if (collector) {
    searchService += ` AND collectors.collector LIKE ?`;
    serviceData.push(`%${collector}%`);
  }

  if (service) {
    searchService += ` AND services.service_name LIKE ?`;
    serviceData.push(`%${service}%`);
  }

  if (collector && service) {
    searchService +=
      " AND (collectors.collector LIKE ? OR services.service_name LIKE ?)";
    serviceData.push(`%${collector}%`);
    serviceData.push(`%${service}%`);
  }

  db.query(searchService, serviceData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};
