class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :address, presence: true
  # validates :user_id, presence: true

  validate :end_time_after_start_time
  serialize :category

  private

  def end_time_after_start_time
    return unless start_time.present? && end_time.present?

    errors.add(:end_time, "must be after the start time") if end_time <= start_time
  end
end
