source 'https://rubygems.org'

ruby '2.6.6'
gem 'rails', '4.2.10'
gem 'uuid'  # used for generate UUID
gem 'bcrypt'
gem 'devise'
gem 'omniauth'
gem 'dotenv-rails'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# for Heroku deployment 
group :development, :test do
  gem 'pg', '~> 0.20'
  # gem 'sqlite3', '1.3.11'
  gem 'byebug'
  gem 'database_cleaner', '1.4.1'
  gem 'capybara', '2.4.4'
  gem 'launchy'
  gem 'rspec-rails', '3.7.2'
  gem 'ZenTest', '4.11.2'
  gem 'guard'
end

group :test do
  gem "devise"
  gem "factory_girl", "~> 4.0"
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end
group :production do
  gem 'pg', '~> 0.20'
end

# Gems used only for assets and not required
# in production environments by default.

gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.7.1'
gem 'jquery-rails'
gem 'jquery-atwho-rails'
