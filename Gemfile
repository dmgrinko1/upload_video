# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'mongoid'
gem 'bson_ext'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'enumerize', '~> 2.3', '>= 2.3.1'
gem 'mongoid-paperclip'
gem 'paperclip-av-transcoder'
gem 'active_model_serializers', '~> 0.10.10'
gem 'bcrypt', '~> 3.1', '>= 3.1.13'
gem 'jwt', '~> 2.2', '>= 2.2.1'
gem 'simple_command', '~> 0.1.0'
gem 'sidekiq', '~> 6.0', '>= 6.0.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', '~> 0.76.0'
  gem 'pry-byebug', platform: :mri
  gem 'pry-rails'
  gem 'factory_bot'
  gem 'ffaker'
  gem 'mongoid-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara-screenshot'
  gem 'capybara-webkit', git: 'https://github.com/thoughtbot/capybara-webkit.git'
  gem 'selenium-webdriver'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
