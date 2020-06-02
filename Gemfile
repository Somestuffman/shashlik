# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'activerecord-postgis-adapter'
gem 'fast_jsonapi'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.2'
gem 'rgeo-geojson'

gem 'bootstrap', '~> 4.3.1'
gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'simple_form'
gem 'slim'
gem 'turbolinks', '~> 5'

gem 'i18n'
gem 'phonelib'
gem 'russian'

gem 'dry-types'
gem 'reform'
gem 'reform-rails'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'mini_magick', '~> 4.8'
gem 'redis', '~> 4.0'
gem 'uglifier'

group :development, :test do
  gem 'awesome-pry'
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  # Deploy

  gem 'bcrypt_pbkdf', '< 2.0'
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'ed25519', '< 2.0'
end

group :test do
  gem 'airborne'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end
