class AvailableAppointmentsQuery
  WORKING_HOURS = (0..23).to_a.freeze
  SESSION_DURATION = 1.hour

  def initialize(psychologist:, date:)
    @psychologist = psychologist
    @date = date.to_date
  end

  def call
    available_appointments
  end

  private

  attr_reader :psychologist, :date

  def available_appointments
    Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      occupied_hour_range = Appointment.where(
        psychologist: psychologist,
        status: :scheduled,
        start_session: date.beginning_of_day..date.end_of_day
      ).pluck(:start_session, :end_session)

      WORKING_HOURS.map do |hour|
        start_time = Time.zone.local(date.year, date.month, date.day, hour)

        end_time = start_time + SESSION_DURATION

        schedule_conflicted = occupied_hour_range.any? do |(start_booked, end_booked)|
          start_time < end_booked && end_time > start_booked
        end

        schedule_conflicted ? nil : start_time
      end.compact
    end
  end

  def cache_key
    "available_appointments/#{psychologist.id}/#{date}"
  end
end
