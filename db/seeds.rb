
Appointment.destroy_all
User.destroy_all


psychologist = User.create!(
  email: 'psico@example.com',
  password: '123456',
  password_confirmation: '123456',
  role: :psychologist
)

patient = User.create!(
  email: 'paciente@example.com',
  password: '123456',
  password_confirmation: '123456',
  role: :patient
)

Appointment.create!(
  psychologist: psychologist,
  patient: patient,
  start_session: 1.day.from_now.change(hour: 9),
  end_session: 1.day.from_now.change(hour: 10),
  status: :scheduled
)

Appointment.create!(
  psychologist: psychologist,
  patient: patient,
  start_session: 2.days.from_now.change(hour: 14),
  end_session: 2.days.from_now.change(hour: 15),
  status: :scheduled
)
