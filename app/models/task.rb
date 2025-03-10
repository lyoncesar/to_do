class Task < ApplicationRecord
  enum :status, { pending: 0, completed: 1 }, default: :pending

  validates :title, presence: true, length: { maximum: 50, minimum: 3 }
  validates :description, length: { maximum: 500 }
end
