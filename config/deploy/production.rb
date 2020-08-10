# frozen_string_literal: true

set :nginx_use_ssl, true
set :branch, :thape
set :sidekiq_service_unit_name, "sidekiq_bluedoc"
set :sidekiq_service_unit_user, :system

server "thape_bluedoc", user: "deployer", roles: %w{app db web}
