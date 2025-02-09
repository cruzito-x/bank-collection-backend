const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");
const { sendMail } = require("../global/mail/mailer");

exports.getCollectorsPayments = (request, response) => {
  const paymentsCollectors =
    "SELECT payments_collectors.payment_id, customers.name AS customer, collectors.collector, services.service_name AS service, payments_collectors.amount, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN customers ON payments_collectors.customer_id = customers.id INNER JOIN collectors ON payments_collectors.collector_id = collectors.id INNER JOIN services ON services.id = payments_collectors.service_id INNER JOIN users ON users.id = payments_collectors.registered_by ORDER BY datetime DESC";

  db.query(paymentsCollectors, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getTotalPaymentsAumount = (request, response) => {
  const totalPaymentsAumount =
    "SELECT SUM(amount) AS amount FROM payments_collectors";

  db.query(totalPaymentsAumount, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.obtainedPaymentsByCollector = (request, response) => {
  const paymentsByCollector =
    "SELECT collector, amount, (amount * 100 / total) AS percentage FROM (SELECT collectors.collector, SUM(payments_collectors.amount) AS amount, (SELECT SUM(amount) FROM payments_collectors) AS total FROM  payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id GROUP BY collectors.collector) AS percentagesByCollector";

  db.query(paymentsByCollector, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.saveNewPayment = (request, response) => {
  const user_id = 1;
  const { customer_id, collector_id, service_id, amount } = request.body;

  if (!customer_id || !collector_id || !service_id || !amount) {
    return response
      .status(400)
      .json({ message: "Por Favor, Rellene Todos los Campos" });
  }

  const getLastPaymentCollectorId =
    "SELECT id FROM payments_collectors ORDER BY id DESC LIMIT 1";

  db.query(getLastPaymentCollectorId, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const lastId = result.length > 0 ? result[0].id + 1 : 0;
    const paymentCollectorId = `PAY${String(lastId).padStart(8, "0")}`;

    const newPayment =
      "INSERT INTO payments_collectors (payment_id, customer_id, collector_id, service_id, amount, registered_by, date_hour) VALUES (?, ?, ?, ?, ?, ?, ?)";

    db.query(
      newPayment,
      [
        paymentCollectorId,
        customer_id,
        collector_id,
        service_id,
        amount,
        user_id,
        new Date(),
      ],
      (error, result) => {
        if (error) {
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        const getCustomerNameAndEmail =
          "SELECT name, email FROM customers WHERE id = ?";

        db.query(getCustomerNameAndEmail, [customer_id], (error, result) => {
          if (error) {
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          const customerName = result[0].name;
          const customerEmail = result[0].email;

          const getCollectorAndServiceName =
            "SELECT collectors.collector, services.service_name AS service FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE collectors.id = ?";

          db.query(
            getCollectorAndServiceName,
            [collector_id],
            async (error, result) => {
              if (error) {
                return response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              }

              const collectorName = result[0].collector;
              const serviceName = result[0].service;

              await sendMail(
                collectorName,
                "xdigitalbit@gmail.com",
                "¡Su Pago ha Sido Aprobado!",
                "Prueba de email",
                customerName,
                serviceName,
                amount
              );

              audit(
                user_id,
                "Pago a Colector Realizado",
                `Pago de $${amount} Realizado a ${collectorName} por ${serviceName}`
              );
            }
          );
        });

        return response.status(200).json({
          message: "¡Pago Registrado Exitosamente!",
        });
      }
    );
  });
};

exports.searchPaymentsCollector = (request, response) => {
  const { collector } = request.query;

  if (!collector) {
    return response.status(400).json({
      message: "Por Favor, Introduzca al Menos un Criterio de Búsqueda",
    });
  }

  const searchPaymentsCollector =
    "SELECT payments_collectors.payment_id, customers.name AS customer, collectors.collector, services.service_name AS service, payments_collectors.amount, users.username AS registered_by, payments_collectors.date_hour AS datetime FROM payments_collectors INNER JOIN customers ON payments_collectors.customer_id = customers.id INNER JOIN collectors ON payments_collectors.collector_id = collectors.id INNER JOIN services ON services.id = payments_collectors.service_id INNER JOIN users ON users.id = payments_collectors.registered_by WHERE collectors.collector LIKE ? ORDER BY datetime DESC";

  db.query(searchPaymentsCollector, [`%${collector}%`], (error, result) => {
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
