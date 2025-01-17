const db = require("../config/db");
const crypto = require("crypto");

exports.getCollectorsPayments = (request, response) => {
  const paymentsCollectors =
    "SELECT customers.name AS customer, collectors.service_name AS service, payments_collectors.amount, payments_collectors.date_hour FROM payments_collectors INNER JOIN customers ON payments_collectors.customer_id = customers.id INNER JOIN collectors ON payments_collectors.collector_id = collectors.id ORDER BY date_hour DESC";

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
    "SELECT collectors.service_name AS service, payments_collectors.amount, (payments_collectors.amount * 100 / (SELECT SUM(payments_collectors.amount) FROM payments_collectors)) AS percentage FROM payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id";

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
  const { customer_id, collector_id, amount } = request.body;
  const getPaymentsCounter =
    "SELECT COUNT(*) AS paymentsCounter FROM payments_collectors";
  const newPayment =
    "INSERT INTO payments_collectors (payment_id, customer_id, collector_id, amount, date_hour) VALUES (?, ?, ?, ?, now());";

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
      [payment_id, customer_id, collector_id, amount],
      (error, result) => {
        if (error) {
          console.error(error);
          return response
            .status(500)
            .json({ message: "Error Interno del Servidor" });
        }

        return response.status(200).json({
          icon: "success",
          message: "¡Pago Registrado Correctamente!",
        });
      }
    );
  });
};
