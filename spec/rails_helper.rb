# frozen_string_literal: true

require 'spec_helper'
require 'support/factory_bot'
require 'mongoid-rspec'
require 'paperclip/matchers'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
  config.include Paperclip::Shoulda::Matchers
end
