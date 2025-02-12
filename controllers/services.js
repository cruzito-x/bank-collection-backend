const db = require("../config/db");
const audit = require("../global/audit/audit");

exports.getServices = (request, response) => {
  const services =
    "SELECT services.*, services.service_name AS service, collectors.collector FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE services.deleted_at IS NULL ORDER BY collectors.collector ASC";

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
  const user_id = request.headers["user_id"];
  const { collector, services } = request.body;

  if (!collector || !Array.isArray(services) || services.length === 0) {
    return response.status(400).json({
      message: "Por Favor, Seleccione un Colector y Rellene Todos los Campos",
    });
  }

  const getLastServiceId = "SELECT id FROM services ORDER BY id DESC LIMIT 1";

  db.query(getLastServiceId, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    let latestId = result.length > 0 ? result[0].id + 1 : 1;

    const servicesToCollector = services.map(
      ({ service, description, price }) => {
        const service_id = `SRV${String(latestId++).padStart(8, "0")}`;
        return [service_id, collector, service, description, price];
      }
    );

    const saveNewServices =
      "INSERT INTO services (service_id, collector_id, service_name, description, price) VALUES ?";

    db.query(saveNewServices, [servicesToCollector], (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      const getCollectorName = "SELECT collector FROM collectors WHERE id = ?";

      db.query(getCollectorName, [collector], (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        const collectorName = result[0].collector;

        services.forEach(({ service }) => {
          audit(
            user_id,
            "Servicio Registrado",
            `Se Registró el Servicio ${service} Para el Colector ${collectorName}`,
            request
          );
        });

        return response
          .status(200)
          .json({ message: "Servicio(s) Registrado(s) con Éxito" });
      });
    });
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
  const { id, startDay, endDay } = request.params;

  const fullStartDate = `${startDay} 00:00:00`;
  const fullEndDate = `${endDay} 23:59:59`;

  const viewPaymentsByServiceDetails =
    "SELECT services.service_name AS service, collectors.collector, payments_collectors.amount, customers.name AS payed_by, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN services ON services.id = payments_collectors.service_id INNER JOIN collectors ON collectors.id = payments_collectors.collector_id INNER JOIN customers ON customers.id = payments_collectors.customer_id INNER JOIN users ON users.id = payments_collectors.registered_by WHERE services.id = ? AND payments_collectors.date_hour BETWEEN ? AND ? ORDER BY datetime DESC";

  db.query(
    viewPaymentsByServiceDetails,
    [id, fullStartDate, fullEndDate],
    (error, result) => {
      if (error) {
        return response
          .status(500)
          .json({ message: "Error Interno del Servidor" });
      }

      return response.status(200).json(result);
    }
  );
};

exports.updateService = (request, response) => {
  const user_id = request.headers["user_id"];
  const { id } = request.params;
  const { collector, service, description, price } = request.body;

  if (!collector || !service || !description || price < 0) {
    return response
      .status(400)
      .json({ message: "Por Favor, Rellene Todos los Campos" });
  }

  const serviceName =
    "SELECT services.service_name FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE services.id = ? AND collectors.collector = ?";

  db.query(serviceName, [id, collector], (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    if (result.length > 0) {
      return response.status(409).json({
        message:
          "Este Servicio ya Está Registrado para El Colector Seleccionado",
      });
    }

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
          `Se Actualizó el Servicio ${service} del Colector ${collector}`,
          request
        );

        return response.status(200).json({
          message: "Datos del Servicio Actualizados con Éxito",
        });
      }
    );
  });
};

exports.deleteService = (request, response) => {
  const user_id = request.headers["user_id"];
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
        `Se Eliminó el Servicio ${service} del Colector ${collector}`,
        request
      );

      return response
        .status(200)
        .json({ message: "Servicio Eliminado con Éxito" });
    });
  });
};

exports.searchService = (request, response) => {
  const { collector, service } = request.query;

  if (!collector && !service) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
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

    if (result.length === 0) {
      return response
        .status(404)
        .json({ message: "No Se Encontraron Resultados" });
    }

    return response.status(200).json(result);
  });
};
