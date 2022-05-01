# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

gem "rails"
gem "mysql2"
gem "puma"
gem "bootsnap", require: false

gem "line-bot-api"
gem "ridgepole"
gem "mini_magick"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "factory_bot_rails"
  gem "rubocop-rails_config"
end

group :development do
  gem "listen"
  gem "spring"
  gem "annotate"
end

group :test do
  gem "rspec-rails"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
