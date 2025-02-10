const moment = require("moment");

const timeRestrictionMiddleware = (request, response, next) => {
  const currentTime = moment();
  const startTime = moment().set({ hour: 0, minute: 30, second: 0 });
  const endTime = moment().set({ hour: 23, minute: 30, second: 0 });

  if (currentTime.isBefore(startTime) || currentTime.isAfter(endTime)) {
    return response.status(403).json({
      message: "El Acceso al Sistema es Inaccesible Fuera del Horario Laboral",
    });
  }

  next();
};

module.exports = { timeRestrictionMiddleware };
