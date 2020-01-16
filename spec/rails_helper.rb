# frozen_string_literal: true

require 'spec_helper'
require 'support/factory_bot'
require 'mongoid-rspec'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model
end
