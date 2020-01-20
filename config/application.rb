require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module VideoUpload
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.load_defaults 6.0
    config.api_only = true
    config.autoload_paths << Rails.root.join('lib')
  end
end
