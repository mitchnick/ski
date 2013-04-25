source 'https://rubygems.org'

# default gems
gem 'rails', '3.2.10'
gem "meta_search",    '>= 1.1.0.pre'
gem 'bcrypt-ruby', '3.0.1'
gem 'jquery-rails', '2.0.2'

# gems for data
gem 'faker', '1.0.1'
gem 'figaro'   # makes data contants local and hidden

# gems for design
gem 'bootstrap-will_paginate', '0.0.6'
gem 'bootstrap-sass'

# gems for users and admin backend
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'activeadmin'
gem 'smarter_csv'

# gems for forms
gem 'simple_form'
gem 'acts-as-taggable-on'
gem 'active_attr'

# gems used for photos
gem 'carrierwave'
gem 'rmagick'
gem 'exifr'

# gems for deploying to the server and for production
gem 'capistrano'

group :production do
  gem 'unicorn'
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end
# platforms :ruby do # linux
# end

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'database_cleaner'
  gem 'email_spec'
end

group :development do
  gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec'
  gem 'cucumber-rails', require: false
  gem 'capybara', '1.1.2'
  gem 'rb-fchange', '0.0.5'
  gem 'rb-notifu', '0.0.4'
  gem 'win32console', '1.3.0'
  gem 'factory_girl_rails', '4.1.0'
  gem 'capybara-screenshot'
  gem 'timecop'
end 