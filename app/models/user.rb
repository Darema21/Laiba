class User < ApplicationRecord
  validates :nickname,:open_id, presence: true
end
