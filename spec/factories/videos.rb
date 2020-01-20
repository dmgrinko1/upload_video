# frozen_string_literal: true

# rubocop:disable Style/MixinUsage
include ActionDispatch::TestProcess
FactoryBot.define do
  factory :video, class: Video do
    start_time { 1 }
    end_time   { 120 }
    state      { 'scheduled' }
    attachment { File.new("#{Rails.root}/spec/support/test_attachment.mp4") }
    user

    trait :no_time_range do
      start_time { nil }
      end_time   { nil }
      state      { 'scheduled' }
      attachment { File.new("#{Rails.root}/spec/support/test_attachment.mp4") }
      user
    end
  end
end
# rubocop:enable Style/MixinUsage
