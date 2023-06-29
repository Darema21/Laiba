class User < ApplicationRecord
  has_many :bookings
  has_many :events
  has_many :booked_events, through: :bookings, source: :event
  has_many :recieved_bookings, through: :events, source: :bookings

  validates :nickname, presence: true

  scope :for_hire, -> { where(for_hire: true) }
end
