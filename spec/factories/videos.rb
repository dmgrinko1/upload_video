# frozen_string_literal: true
include ActionDispatch::TestProcess
# rubocop:disable Style/MixinUsage
FactoryBot.define do
  factory :video, class: Video do
    start_time { 1 }
    end_time   { 120 }
    state      { 'scheduled' }
    attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'test_attachment.mp4'), 'video/mp4') }
    user

    trait :no_time_range do
      start_time { nil }
      end_time   { nil }
      state      { 'scheduled' }
      attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'test_attachment.mp4'), 'video/mp4') }

      user
    end
  end
end
# rubocop:enable Style/MixinUsage
