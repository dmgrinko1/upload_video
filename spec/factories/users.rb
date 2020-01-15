# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
    auth_token { SecureRandom.uuid }
  end
end
