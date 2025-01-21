const db = require("../config/db");
const crypto = require("crypto");
const audit = require("../global/audit/audit");
const { sendMail } = require("../global/mail/mailer");
const moment = require("moment");

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
  const getCustomerNameAndEmail =
    "SELECT name, email FROM customers WHERE id = ?";
  const getCollectorAndServiceName =
    "SELECT collectors.service_name AS collector, services.service_name AS service FROM services INNER JOIN collectors ON collectors.id = services.collector_id WHERE collectors.id = ?";

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

        db.query(getCustomerNameAndEmail, [customer_id], (error, result) => {
          if (error) {
            console.error(error);
            return response
              .status(500)
              .json({ message: "Error Interno del Servidor" });
          }

          const customerName = result[0].name;
          const customerEmail = result[0].email;

          db.query(
            getCollectorAndServiceName,
            [collector_id],
            async (error, result) => {
              if (error) {
                console.error(error);
                return response
                  .status(500)
                  .json({ message: "Error Interno del Servidor" });
              }

              const collectorName = result[0].collector;
              const serviceName = result[0].service;

              await sendMail(
                // customerEmail,
                "xdigitalbit@gmail.com",
                "Pago de Servicio Éxitoso",
                `<div style="font-family: Arial, sans-serif; color: #333333; line-height: 1.6; margin: 0; padding: 20px; background-color: #eef1f7; border: none; border-radius: 8px; max-width: 600px; margin: auto;">
                <p style="margin: 0 0 20px; font-size: 16px;"> Hola, <br />
                <span style="font-size: 18px; font-weight: bold;">${customerName}</span><br />
                Tu pago de <span style="font-weight: bold; color: #16bb69;">$${amount}</span>
                por el servicio de <strong>${serviceName}</strong> de <strong>${collectorName}</strong> ha sido registrado correctamente. </p>
                
                <div style="text-align: center; margin: 20px 0;">
                <p style="margin: 0; font-size: 14px; color: #555555;"> Cancelado el día: <strong style="font-size: 16px; color: #333333;">${moment(new Date()).format("DD/MM/YYYY hh:mm a")}</strong> </p>
                </div>
                
                <div style="margin-top: 20px; padding: 15px; background-color: #f5f5f5; border: 1px solid #eeeeee; border-radius: 8px;">
                <p style="margin: 0; font-size: 14px; color: #555555;"> Este es un comprobante de pago. Para mayor información, consulta con tu banco o contacta a 
                <a href="mailto:onboarding@resend.dev" style="color: #007bff; text-decoration: none;">onboarding@resend.dev</a>. </p>
                </div>
                
                <p style="margin-top: 20px; font-size: 16px; color: #333;"> Feliz Día. <br />
                <strong>Att. El Banco</strong>
                </p>
                </div>`
              );
            }
          );
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
