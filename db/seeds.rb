Payment.destroy_all if defined?(Payment)
Appointment.destroy_all
User.destroy_all


# ---- Psicólogos ----
psychologists = [
  { email: 'psico1@example.com', password: '123456' },
  { email: 'psico2@example.com', password: '123456' }
].map do |attrs|
  User.create!(attrs.merge(role: :psychologist, password_confirmation: attrs[:password]))
end

# ---- Pacientes ----
patients = [
  { email: 'paciente1@example.com', password: '123456' },
  { email: 'paciente2@example.com', password: '123456' },
  { email: 'paciente3@example.com', password: '123456' }
].map do |attrs|
  User.create!(attrs.merge(role: :patient, password_confirmation: attrs[:password]))
end

# ---- Agendamentos ----
statuses = [ :scheduled, :completed, :cancelled ]

appointments = 10.times.map do
  start_time = rand(1..30).days.from_now.change(hour: rand(8..17))
  end_time = start_time + 1.hour
  Appointment.create!(
    psychologist: psychologists.sample,
    patient: patients.sample,
    start_session: start_time,
    end_session: end_time,
    status: statuses.sample,
    session_value: [ 50, 80, 100, 120 ].sample
  )
end

# ---- Pagamentos ----
payment_statuses = [ :paid, :pending, :failed ]

appointments.each do |appt|
  Payment.create!(
    user: appt.patient,
    appointment: appt,
    amount: appt.session_value,
    status: payment_statuses.sample,
    created_at: appt.start_session - rand(0..2).days
  )
end

puts "Seed completo:"
puts "- Usuários: #{User.count}"
puts "- Agendamentos: #{Appointment.count}"
puts "- Pagamentos: #{Payment.count}" if defined?(Payment)
