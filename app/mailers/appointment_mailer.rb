class AppointmentMailer < ApplicationMailer
  default from: "no-reply@psyagenda.com"

  def upcoming_appointment_email(appointment)
    @appointment = appointment
    mail(to: @appointment.patient.email, subject: "LEMBRETE CONSULTA AGENDADA")
  end
end
