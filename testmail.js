import { Resend } from 'resend';

const resend = new Resend('re_YaXUdEVA_NudsEZxQL3rASJoys4yPGFjR');

await resend.emails.send({
  from: 'BANCO X <onboarding@resend.dev>',
  to: 'xdigitalbit@gmail.com',
  subject: 'hello world',
  html: '<p>it works!</p>',
});