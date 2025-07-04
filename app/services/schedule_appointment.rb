class ScheduleAppointment
  class Error < StandardError; end

  def self.call(**params)
    new(**params).call
  end

  def initialize(psychologist:, patient:, start_session:, end_session:)
    @psychologist = psychologist
    @patient = patient
    @start_session = start_session
    @end_session = end_session
  end

  def call
    validate_schedule!
    create_appointment!
  end

  private

  attr_reader :psychologist, :patient, :start_session, :end_session

  def validate_schedule!
    raise Error, "Paciente e psicólogo devem ser diferentes" if psychologist.id == patient.id
    raise Error, "Horário inválido" if start_session >= end_session

    schedule_conflicted = Appointment.where(psychologist: psychologist)
      .where("start_session < ? AND end_session > ?", end_session, start_session)
      .exists?

    raise Error, "Conflito com outro agendamento" if schedule_conflicted
  end

  def create_appointment!
    appointment = Appointment.create!(
      psychologist: psychologist,
      patient: patient,
      start_session: start_session,
      end_session: end_session,
      status: :scheduled
    )

    NotifyUpcomingAppointmentJob.set(wait_until: 10.seconds).perform_later(appointment.id)
  end
end
