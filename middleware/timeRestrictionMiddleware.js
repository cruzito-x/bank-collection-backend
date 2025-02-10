const moment = require("moment");

const timeRestrictionMiddleware = (request, response, next) => {
  const currentHour = moment();
  const startHour = moment().set({ hour: 8, minute: 30, second: 0 });
  const endHour = moment().set({ hour: 16, minute: 30, second: 0 });

  if (currentHour.isBefore(startHour) || currentHour.isAfter(endHour)) {
    return response.status(403).json({
      message: "El Acceso al Sistema es Inaccesible Fuera del Horario Laboral",
    });
  }

  next();
};

module.exports = { timeRestrictionMiddleware };
