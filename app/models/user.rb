class User < ApplicationRecord
  validates :nickname, presence: true
end
