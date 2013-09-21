source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'pg'
gem 'slim'
gem 'slim-rails'
gem 'formtastic'
gem 'rails3-jquery-autocomplete'
gem 'formtastic-bootstrap'
gem 'cocoon'
#using prawn edge due to undefined method position bug
#https://github.com/prawnpdf/prawn/issues/150
#if edge ceases to work can use :ref => "8028ca0cd2"
#as last known working commit
gem 'prawn', github: "prawnpdf/prawn" 
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'sass-rails',   '~> 3.2.3'
gem 'newrelic_rpm'
gem 'pony'
gem 'honeybadger'
gem 'heroku'
gem "acts_as_archival"
gem "riif"

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
  gem 'less-rails'
  gem 'therubyracer'
  gem 'jquery-ui-rails'
end

group :development do
  gem 'bullet'
end
group :test, :development do
  gem 'launchy'
  gem 'pry'
  gem "rspec-rails", "~> 2.0"
end
group :test do
  gem 'turnip'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rb-fsevent'
  gem 'guard-rspec'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock', '~> 1.9.0'
  gem 'factory_girl_rails'
  gem 'selenium-webdriver'
end
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'jquery-rails'
