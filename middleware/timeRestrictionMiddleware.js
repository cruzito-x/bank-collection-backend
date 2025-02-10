const moment = require("moment");

const timeRestrictionMiddleware = (request, response, next) => {
  const currentTime = moment();
  const startTime = moment().set({ hour: 8, minute: 30, second: 0 });
  const endTime = moment().set({ hour: 16, minute: 30, second: 0 });

  // const startTime = moment().set({ hour: 0, minute: 0, second: 0 });
  // const endTime = moment().set({ hour: 23, minute: 59, second: 59 });

  if (currentTime.isBefore(startTime) || currentTime.isAfter(endTime)) {
    return response.status(403).json({
      message: "El Acceso al Sistema es Inaccesible Fuera del Horario Laboral",
    });
  }

  next();
};

module.exports = { timeRestrictionMiddleware };
