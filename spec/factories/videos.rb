# frozen_string_literal: true

FactoryBot.define do
  factory :video, class: Video do
    name { FFaker::Name.name }
    user
  end
end
