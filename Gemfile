ruby "3.1.1"

source "https://rubygems.org"

gem "rails", "~> 7.2.0"
gem "sprockets-rails"
gem 'pg'
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false
gem "sidekiq", "~> 7.3"
#
gem 'devise'
gem 'haml'
gem 'breadcrumbs'
gem 'kaminari'
gem 'money'
gem 'money-rails', '~>1.12'
gem 'country_select', '~> 4.0'
gem 'font-awesome-rails'
gem 'activeadmin'
gem 'activeadmin_froala_editor'
gem 'aws-sdk-s3'
gem 'rack-cors', require: 'rack/cors'
gem "mini_magick"
gem 'will_paginate', '~> 3.3'
gem 'friendly_id', '~> 5.4.0'
gem 'acts-as-taggable-on', github: 'adbelsham/acts-as-taggable-on', branch: 'master'
gem 'rails-observers'
gem 'sass-rails'
gem 'cancancan'
gem 'draper'
gem 'pundit'
gem 'activestorage'
gem "image_processing"
gem 'jquery-rails'
gem 'popper_js'
gem 'bootstrap', '~> 5.1', '>= 5.1.3'
gem 'rest-client'
gem "redis"
gem "redis-actionpack"


group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem 'pry'
  gem 'dotenv-rails'
end

group :development do
  gem 'letter_opener'
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
