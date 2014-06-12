#gems
gem 'rails-api'
gem 'pg'
gem 'unicorn'
gem 'hat',      git: 'git@github.com:hooroo/hooroo-api-tools.git'
gem 'query_ar', git: 'git@github.com:hooroo/query_ar.git'
gem 'stethoscope'
gem 'http_client', git: 'git@github.com:hooroo/http_client.git'
gem 'togglr', git: 'git@github.com:hooroo/togglr.git'
gem 'faraday'

gem 's3_uri', git: 'git@github.com:hooroo/s3_uri.git'

group_group :development do
  gem 'foreman'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-debugger' unless ENV['RUBYMINE_ZEUS'] || ENV['RM_INFO']
  gem 'pry-remote'
end

gem_group :test do
  gem 'vcr'
  gem 'pact', git: 'git@github.com:hooroo/pact.git'
  gem 'codeclimate-test-reporter', require: nil
  gem 'mock_redis'
end

#generators
generate('rspec:install')

#Foreman Start Procfile
run "echo 'web: bundle exec unicorn_rails --config-file config/unicorn.rb' >> Procfile"
run "echo 'web_log: touch log/development.log log/unicorn.log ; tail -f log/development.log log/unicorn.log' >> Procfile"

#gitignore
run "cat << EOF >> .gitignore
/.bundle
/log/*.log
/tmp
database.yml
doc/
*.swp
*~
.DS_Store
EOF"

#git
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }