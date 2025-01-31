const { Resend } = require("resend");
const moment = require("moment");
const resend = new Resend(process.env.RESEND_API_KEY);

const isValidateEmail = (email) => {
  const validateEmailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  return validateEmailPattern.test(email);
};

const sendMail = async (
  from,
  to,
  subject,
  text,
  customerName,
  serviceName,
  amount
) => {
  if (!isValidateEmail(to)) {
    return;
  } else {
    try {
      const result = await resend.emails.send({
        from: from + process.env.RESEND_SENDER,
        to,
        subject,
        text,
        html: `<p style="text-align: center; font-size: 15px">
        <strong>¡Hola!</strong> El pago de tu factura fue exitoso. ¡Gracias por utilizar los servicios de <strong style="color: #007bff;">${from}</strong>!
        </p>
        <div style="font-family: Montserrat, Arial; width: 350px; margin: auto; padding: 15px; border: 1px solid #c9c9c9; border-radius: 20px; background-color: #ffffff;">
          <h1 style="text-align: center; font-size: 60px; color: #000000;">$${amount}</h1>
          <p style="text-align: center; font-size: 13px; color: #000000; margin-top: -45px;">
            <strong style="font-size: 13px;"> ¡Pago Exitoso! </strong>
          </p>
          <div style="margin: 10px 0;">
            <p style="font-size: 14px; color: #000000;">
              <strong>Cliente</strong> <br />
			  <label style="color: #5b5b5b;"> ${customerName} </label>
            </p>
            <p style="font-size: 14px; color: #000000;">
              <strong>Proveedor</strong> <br />
              <label style="color: #5b5b5b;"> ${from} </label>
            </p>
            <p style="font-size: 14px; color: #000000;">
              <strong>Concepto</strong> <br />
			  <label style="color: #5b5b5b;"> ${serviceName} </label>
            </p>
            <p style="font-size: 14px; color: #000000;">
              <strong>Fecha de Pago</strong> <br />
              <label style="color: #5b5b5b;"> ${moment(new Date()).format("YYYY/MM/DD - hh:mm A")}</label>
            </p>
          </div>
        </div>
        
        <div style="text-align: center; margin-top: 20px">
          <p style="margin: 0; font-size: 14px; color: #000000;"> Este es un comprobante de pago. <br />
          Para mayor información, consulta en las oficinas del banco o contacta a <a href="mailto:onboarding@resend.dev" style="color: #007bff; text-decoration: none;">onboarding@resend.dev</a>. </p>
          <p> &copy; cruzito-x - ${new Date().getFullYear()} All Rights Reserved. </p>
        </div>`,
      });
      console.log("Email sent:", result);
    } catch (error) {
      console.error("Error sending email:", error);
    }
  }
};

module.exports = { sendMail };
