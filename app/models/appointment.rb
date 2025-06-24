class Appointment < ApplicationRecord
  belongs_to :psychologist, class_name: "User"
  belongs_to :patient, class_name: "User"

  enum status: { scheduled: "scheduled", cancelled: "cancelled", completed: "completed" }

  validates :start_session, :end_session, presence: true
end
