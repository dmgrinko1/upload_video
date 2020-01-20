# frozen_string_literal: true

require 'spec_helper'
require 'support/factory_bot'
require 'mongoid-rspec'
require 'paperclip/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include RequestSpecHelper
  config.include ControllerSpecHelper
  config.include(Shoulda::Callback::Matchers::ActiveModel)
  config.include Mongoid::Matchers, type: :model
  config.include Paperclip::Shoulda::Matchers
end
