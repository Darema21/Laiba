class User < ApplicationRecord
  validates :open_id, :nickname, presence: true
end
