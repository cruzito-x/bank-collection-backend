const moment = require("moment");
const db = require("../config/db");

exports.getLatestCollectorAndCollectorPayemntData = (request, response) => {
  const getLatestData =
    "SELECT collectors.service_name AS collector, (SELECT collectors.service_name FROM collectors ORDER BY collectors.id DESC LIMIT 1) AS most_recent_collector, payments_collectors.amount, (SELECT transactions.transaction_id FROM transactions INNER JOIN approvals ON approvals.transaction_id = transactions.id WHERE approvals.is_approved IS NOT NULL AND approvals.is_approved = 1 ORDER BY approvals.transaction_id DESC LIMIT 1) AS latest_approved_transaction FROM collectors INNER JOIN payments_collectors ON payments_collectors.collector_id = collectors.id ORDER BY payments_collectors.date_hour DESC LIMIT 1";

  db.query(getLatestData, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getTransactionsByDates = (request, response) => {
  const { startDay, endDay, amountFilter, transactionTypeFilter } =
    request.params;

  let amountRange;
  switch (parseInt(amountFilter, 10)) {
    case 1:
      amountRange = [1, 99];
      break;
    case 2:
      amountRange = [100, 499];
      break;
    case 3:
      amountRange = [500, 999];
      break;
    case 4:
      amountRange = [1000, 1999];
      break;
    case 5:
      amountRange = [2000, 4999];
      break;
    case 6:
      amountRange = [5000, 1000000000];
      break;
    default:
      amountRange = [1, 99];
      break;
  }

  const fullStartDate = `${startDay} 00:00:00`;
  const fullEndDate = `${endDay} 23:59:59`;

  const differenceInDays =
    (new Date(endDay) - new Date(startDay)) / (1000 * 60 * 60 * 24);

  let transactionsByDates;
  const transactionsByDatesParams = [
    fullStartDate,
    fullEndDate,
    transactionTypeFilter,
    amountRange[0],
    amountRange[1],
  ];

  if (differenceInDays === 0) {
    // Today
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%W') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE transactions.date_hour BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  } else if (differenceInDays >= 7 && differenceInDays < 31) {
    // Last 7 days
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%W') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  } else if (differenceInDays >= 31 && differenceInDays < 90) {
    // Last Month
    transactionsByDates = `SELECT CONCAT(${startDay}, ' - ', ${endDay}) AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ?`;
  } else if (differenceInDays >= 90 && differenceInDays < 182) {
    // Last quarter
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%M %Y') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  } else if (differenceInDays >= 182 && differenceInDays < 365) {
    // Last Semester
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%M %Y') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  } else if (differenceInDays >= 365) {
    // Last Year
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%M %Y') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  } else {
    // Last week
    transactionsByDates =
      "SELECT DATE_FORMAT(transactions.date_hour, '%W') AS interval_name, SUM(transactions.amount) AS totalAmount, COUNT(transactions.id) AS transactionsCounter FROM transactions INNER JOIN transaction_types ON transaction_types.id = transactions.transaction_type_id WHERE DATE(transactions.date_hour) BETWEEN ? AND ? AND transactions.transaction_type_id = ? AND transactions.amount BETWEEN ? AND ? GROUP BY interval_name ORDER BY MIN(transactions.date_hour) ASC";
  }

  db.query(transactionsByDates, transactionsByDatesParams, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const transactionsByDatesResults =
      differenceInDays >= 31 && differenceInDays < 90
        ? [
            {
              label: `${moment(startDay).format("DD/MM/YYYY")} - ${moment(
                endDay
              ).format("DD/MM/YYYY")}`,
              totalAmount: result[0]?.totalAmount || 0,
              transactionsCounter: result[0]?.transactionsCounter || 0,
            },
          ]
        : result.map((row) => ({
            label: row.interval_name,
            totalAmount: row.totalAmount,
            transactionsCounter: row.transactionsCounter,
          }));

    return response.status(200).json(transactionsByDatesResults);
  });
};

exports.getTransactionsByCollector = (request, response) => {
  const transactionsByCollector =
    "SELECT collectors.service_name AS collector, COUNT(*) AS transactionsByCollector FROM payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id GROUP BY payments_collectors.collector_id;";

  db.query(transactionsByCollector, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    return response.status(200).json(result);
  });
};

exports.getTransactionsByDenomination = (request, response) => {
  const transactionsByDenomination = "SELECT amount FROM payments_collectors";

  db.query(transactionsByDenomination, (error, result) => {
    if (error) {
      return response
        .status(500)
        .json({ message: "Error Interno del Servidor" });
    }

    const denominations = [100, 50, 20, 10, 5, 2, 1, 0.25, 0.1, 0.05, 0.01];
    let denominationsCounter = {};

    denominations.forEach((denomination) => {
      denominationsCounter[denomination] = 0;
    });

    result.forEach((paymentsCollectors) => {
      let amount = paymentsCollectors.amount;

      denominations.forEach((denomination) => {
        if (amount >= denomination) {
          const counter = Math.floor(amount / denomination);

          denominationsCounter[denomination] += counter;
          amount = (amount % denomination).toFixed(2);
        }
      });
    });

    const totalDenominations = denominations.map((denomination) => ({
      denomination:
        `${denomination >= 1 ? "Billetes de:" : "Monedas de:"} $` +
        denomination.toFixed(2),
      total: denominationsCounter[denomination],
    }));

    return response.status(200).json(totalDenominations);
  });
};
