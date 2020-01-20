# frozen_string_literal: true

require 'spec_helper'
require 'support/factory_bot'
require 'mongoid-rspec'
require 'paperclip/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include Mongoid::Matchers, type: :model
  config.include Paperclip::Shoulda::Matchers
end
