require("dotenv").config();
const nodemailer = require("nodemailer");
const { google } = require("googleapis");

const oAuth2Client = new google.auth.OAuth2(
  process.env.MAIL_CLIENT_ID,
  process.env.MAIL_CLIENT_SECRET,
  process.env.MAIL_REDIRECT_URI
);

oAuth2Client.setCredentials({
  refresh_token: process.env.MAIL_SENDER_REFRESH_TOKEN,
});

async function sendMail(customer_email, subject, text) {
  try {
    const accessToken = await oAuth2Client.getAccessToken();
    if (!accessToken.token) {
      throw new Error("No se pudo obtener el token de acceso");
    }

    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        type: "OAuth2",
        user: process.env.MAIL_SENDER,
        pass: process.env.MAIL_SENDER_PASSWORD,
        refreshToken: process.env.MAIL_SENDER_REFRESH_TOKEN,
        accessToken: accessToken.token,
      },
    });

    const mailOptions = {
      from: process.env.MAIL_SENDER,
      to: customer_email,
      subject: subject,
      text: text,
    };

    const result = await transporter.sendMail(mailOptions);
    console.log("Email sent to:", customer_email);
    return result;
  } catch (error) {
    console.error("Error sending mail:", error.message);
    throw new Error("Error sending mail: " + error.message);
  }
}

module.exports = { sendMail };
