#gems
gem 'rails-api'
gem 'pg'
gem 'unicorn'
gem 'hat',      git: 'git@github.com:hooroo/hooroo-api-tools.git'
gem 'query_ar', git: 'git@github.com:hooroo/query_ar.git'
gem 'stethoscope'
gem 'http_api_client', git: 'git@github.com:hooroo/http_api_client.git'
gem 'togglr', git: 'git@github.com:hooroo/togglr.git'
gem 'faraday'

gem 's3_uri', git: 'git@github.com:hooroo/s3_uri.git'

gem_group :development do
  gem 'foreman'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-byebug'
end

gem_group :test do
  gem 'vcr'
  gem 'pact', git: 'git@github.com:hooroo/pact.git'
  gem 'codeclimate-test-reporter', require: nil
  gem 'mock_redis'
end

#Foreman Start Procfile
file 'Procfile', <<-PROCFILE
  web: bundle exec unicorn_rails --config-file config/unicorn.rb
  web_log: touch log/development.log log/unicorn.log ; tail -f log/development.log log/unicorn.log
PROCFILE

#rspec
file '.rspec', <<-RSPEC
  --color
  --format documentation
  --profile
RSPEC

#pact
file 'spec/support/pact_helper.rb', <<-PACT
  $LOAD_PATH << File.join(File.dirname(__FILE__),'../..','spec')
  require 'spec_helper'
  require 'api_clients'
  require 'pact/consumer/rspec'

  Pact.configure do | config |
    config.pact_dir = "spec/integration/pacts"
    config.logger.level = Logger::DEBUG
    config.pactfile_write_mode = :overwrite
  end
PACT

#gitignore
file '.gitignore', <<-GITIGNORE
  /.bundle
  /log/*.log
  /tmp
  database.yml
  doc/
  *.swp
  *~
  .DS_Store
GITIGNORE

#git
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }