# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { FFaker::Internet.email }
    password { 'securePassword1' }
    password_confirmation { 'securePassword1' }
  end
end
