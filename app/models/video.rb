# frozen_string_literal: true

class Video
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String
  field :start_time, type: Integer
  field :end_time, type: Integer

  belongs_to :user, index: true

  index({ user_id: 1 }, unique: true)

  validates :name,
            presence: true,
            length: { in: 3..50 }

  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return unless start_time.present? && end_time.present?

    errors.add(:end_date, 'must be after the start time') if end_time < start_time
  end
end
