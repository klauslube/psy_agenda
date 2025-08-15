class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment, optional: true

  enum status: { pending: "pending", paid: "paid", failed: "failed" }

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
