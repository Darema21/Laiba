class User < ApplicationRecord
  has_many :bookings
  has_many :events, through: :bookings

  validates :open_id, :nickname, presence: true
end
