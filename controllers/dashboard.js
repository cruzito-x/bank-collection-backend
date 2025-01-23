const db = require("../config/db");

exports.getTransactionsByCollector = (request, response) => {
  const transactionsByCollector = "SELECT collectors.service_name AS collector, COUNT(*) AS transactionsByCollector FROM payments_collectors INNER JOIN collectors ON collectors.id = payments_collectors.collector_id GROUP BY payments_collectors.collector_id;";
  
  db.query(transactionsByCollector, (error, result) => {
    if(error) {
      return response.status(500).json({ message: "Error Interno del Servidor"});
    }

    return response.status(200).json(result);
  });
}

exports.getTransactionsByDenomination = (request, response) => {
  const transactionsByDenomination = "SELECT amount FROM payments_collectors";

  db.query(transactionsByDenomination, (error, result) => {
    if (error) {
      return response.status(500).json({ message: "Error Interno del Servidor" });
    }

    const denominations = [100, 50, 20, 10, 5, 2, 1, 0.25, 0.1, 0.05, 0.01];
    let denominationsCounter = {};

    denominations.forEach(denomination => {
      denominationsCounter[denomination] = 0;
    });


    result.forEach(paymentsCollectors => {
      let amount = paymentsCollectors.amount;


      denominations.forEach(denomination => {
        if (amount >= denomination) {
          const counter = Math.floor(amount / denomination);
          
          denominationsCounter[denomination] += counter;
          amount = (amount % denomination).toFixed(2);
        }
      });
    });

    const totalDenominations = denominations.map(denomination => ({
      denomination: `${ denomination >= 1 ? "Billetes de:" : "Monedas de:"} $`+denomination.toFixed(2), // Convertir a formato de string para monedas como "0.25"
      total: denominationsCounter[denomination]
    }));

    return response.status(200).json(totalDenominations);
  });
};
