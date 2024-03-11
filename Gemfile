# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'redis', '~> 4.0'
# gem 'image_processing', '~> 1.2'
gem 'jbuilder'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'cancancan'
gem 'cpf_faker'
gem 'jwt'
gem 'kaminari'
gem 'paranoia', '~> 2.2'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rack-session'
gem 'rails', '~> 7.0.4'
gem 'ransack'
gem 'redis'
gem 'rswag-api'
gem 'rswag-ui'
gem 'sidekiq'

group :development, :test do
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'listen', '~> 3.3'
  gem 'rspec-json_expectations'
  gem 'rspec-rails'
  gem 'rswag-specs'
  gem 'rubocop-faker'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rails_config'
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'spring'
  # gem 'mailcatcher'
end

group :test do
  gem 'database_cleaner'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
