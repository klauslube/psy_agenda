class NotifyUpcomingAppointmentJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.find_by(id: appointment_id)

    return nil if appointment.blank? || appointment.cancelled?

    Rails.logger.info
    "Consulta de #{appointment.patient.email} com #{appointment.psychologist.email} às #{appointment.start_session.strftime('%H:%M')}."
  end
end
