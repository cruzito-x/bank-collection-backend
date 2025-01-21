const { Resend } = require("resend");
const resend = new Resend(process.env.RESEND_API_KEY);

const isValidateEmail = (email) => {
  const validateEmailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  return validateEmailPattern.test(email);
};

const sendMail = async (from, to, subject, text, html) => {
  if (!isValidateEmail(to)) {
    return;
  } else {
    try {
      const result = await resend.emails.send({
        from: from+process.env.RESEND_SENDER,
        to,
        subject,
        text,
        html,
      });
      console.log("Email sent:", result);
    } catch (error) {
      console.error("Error sending email:", error);
    }
  }
};

module.exports = { sendMail };
