const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");
const { sendMail } = require("../global/mail/mailer");

exports.getCollectorsPayments = (request, response) => {
  const paymentsCollectors =
    "SELECT customers.name AS customer, collectors.service_name AS collector, services.service_name AS service, payments_collectors.amount, payments_collectors.date_hour FROM payments_collectors INNER JOIN customers ON payments_collectors.customer_id = customers.id INNER JOIN collectors ON payments_collectors.collector_id = collectors.id INNER JOIN services ON services.id = payments_collectors.service_id ORDER BY date_hour DESC";

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

exports.paymentsByCollector = (request, response) => {
  const paymentsByCollector =
    "SELECT service, amount, (amount * 100 / total) AS percentage FROM (SELECT collectors.service_name AS service, SUM(payments_collectors.amount) AS amount, (SELECT SUM(amount) FROM payments_collectors) AS total FROM  payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id GROUP BY collectors.service_name) AS percentagesByCollector";

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
  const { customer_id, collector_id, service_id, amount } = request.body;
  const getPaymentsCounter =
    "SELECT COUNT(*) AS paymentsCounter FROM payments_collectors";
  const newPayment =
    "INSERT INTO payments_collectors (payment_id, customer_id, collector_id, service_id, amount, date_hour) VALUES (?, ?, ?, ?, ?, now());";
  const getCustomerEmail = "SELECT email FROM customers WHERE id = ?";

  db.query(getPaymentsCounter, (error, result) => {
    if (error) {
      console.error(error);
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const paymentsCounter = result[0].paymentsCounter;
    const payment_id = crypto
      .createHash("sha256")
      .update((paymentsCounter + 1).toString())
      .digest("hex");

    db.query(
      newPayment,
      [payment_id, customer_id, collector_id, service_id, amount],
      (error, result) => {
        if (error) {
          console.error(error);
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        db.query(getCustomerEmail, [customer_id], async (error, result) => {
          if (error) {
            console.error(error);
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          const customerEmail = result[0].email;

          try {
            await sendMail(
              customerEmail,
              "BANCO - ¡PAGO DE SERVICIO ÉXITOSO!",
              "Esta es una prueba de correo electrónico"
            );
          } catch (error) {
            console.error("Error sending mail:", error);
            response
              .status(500)
              .json({ message: "Error al Enviar la Factura" });
          }
        });

        // audit(
        //   result[0].id,
        //   "Pago a Colector",
        //   "Pago Realizado a Colector"
        // );

        return response.status(200).json({
          message: "¡Pago Registrado Correctamente!, Factura Enviada",
        });
      }
    );
  });
};
