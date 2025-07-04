class CancelAppointment
  class Error < StandardError; end

  def self.call(appointment:, requested_by:)
    new(appointment, requested_by).call
  end

  def initialize(appointment, requested_by)
    @appointment = appointment
    @requested_by = requested_by
  end

  def call
    validate!
    cancel!
    appointment
  end

  private

  attr_reader :appointment, :requested_by

  def validate!
    unless [ appointment.psychologist_id, appointment.patient_id ].include?(requested_by.id)
      raise Error, "Usuário não autorizado a cancelar este agendamento"
    end

    if appointment.status == "cancelled"
      raise Error, "Agendamento já está cancelado"
    end

    if appointment.end_session < Time.current
      raise Error, "Não é possível cancelar agendamentos passados"
    end
  end

  def cancel!
    appointment.update!(status: :cancelled)
  end
end
