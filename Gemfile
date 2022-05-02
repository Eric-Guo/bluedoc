# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", '~> 6.1.5'
gem "pg", "~> 1.2.3"
gem "redis", "~> 4.5.1" # need by new redis-objects v1.6.0
gem "redis-objects"
gem "puma", "~> 4.3.8"
gem "react-rails"

gem "graphql", '~> 1.8.14'

gem "sidekiq"

gem "webpacker"
gem "turbolinks"
gem "jbuilder"
gem "kaminari"

gem "awesome_nested_set"

gem "aws-sdk-s3", require: false
gem "mini_magick"
gem "image_processing", "~> 1.2"
# validates :avatar, file_size:
gem "file_validators"
gem "twemoji"

gem "bootsnap"

gem "rails-i18n"
gem "rails-settings-cached"

gem "elasticsearch-model", "~> 6"
gem "elasticsearch-rails", "~> 6"

gem "second_level_cache"

gem "devise"
gem "omniauth-rails_csrf_protection"
gem "omniauth-ldap"
gem "omniauth-google-oauth2"
gem "omniauth-github"
gem "omniauth-gitlab"
gem "cancancan"

gem "activestorage-aliyun"
gem "notifications"
gem "action-store"
gem "exception-track"
gem "status-page"
gem "rucaptcha"
gem "enumize"
gem "auto-correct"

gem "html-pipeline"
gem "html-pipeline-auto-correct"
gem "commonmarker"
gem "rouge"
gem "sanitize"

gem "bluedoc-toc"
gem "bluedoc-sml"

gem "wicked_pdf"

gem "pghero"

gem "foreman"

gem "jira-ruby"

gem "rake"

group :development, :test do
  gem "mocha"
  gem "letter_opener"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "brakeman"
  gem "simplecov"
  gem "codecov"

  gem "capistrano"
  gem "capistrano-rails"
  gem "capistrano-rbenv"
  gem "capistrano3-puma"
  gem "capistrano-sidekiq"
end

group :development do
  gem "web-console"
  gem "listen"
  gem "spring"
  gem "standard"
  gem "graphiql-rails"
end
