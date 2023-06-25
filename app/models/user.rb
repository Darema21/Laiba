class User < ApplicationRecord
  has_many :bookings
  has_many :events

  validates :nickname, presence: true
end
