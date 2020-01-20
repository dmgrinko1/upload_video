# frozen_string_literal: true

class Video
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::Paperclip

  extend Enumerize

  enumerize :state, in: {
    scheduled: 'scheduled',
    processing: 'processing',
    done: 'done',
    failed: 'failed'
  }, default: :scheduled

  field :start_time, type: Integer
  field :end_time, type: Integer
  field :state, type: String

  has_mongoid_attached_file :attachment

  belongs_to :user, index: true

  index({ user_id: 1 }, unique: true)

  validates :state,      presence: true
  validates :start_time, presence: true, if: :end_time?
  validates :end_time,   presence: true, if: :start_time?

  validate :end_time_after_start_time

  validates_attachment_presence     :attachment
  validates_attachment_content_type :attachment, content_type: ['video/mp4']
  validates_attachment              :attachment, size: { less_than: 200.megabytes }

  private

  def end_time_after_start_time
    return unless start_time.present? && end_time.present?

    errors.add(:end_date, 'must be after the start time') if end_time < start_time
  end
end
