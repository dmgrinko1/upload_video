# frozen_string_literal: true

# rubocop:disable Style/MixinUsage
include ActionDispatch::TestProcess
FactoryBot.define do
  factory :video, class: Video do
    start_time { 1 }
    end_time   { 120 }
    attachment { File.new("#{Rails.root}/spec/support/test_attachment.mp4") }
    user
  end
end
# rubocop:enable Style/MixinUsage
