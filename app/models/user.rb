class User < ApplicationRecord
  has_many :bookings
  has_many :events

  validates :nickname, presence: true

  scope :for_hire, -> { where(for_hire: true) }
end
