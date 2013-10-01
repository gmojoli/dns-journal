source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '  ~> 4.0.0'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

gem 'pg'

group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails'#, '~> 4.0.0.rc2'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'
  gem "foundation-icons-sass-rails", github: 'zaiste/foundation-icons-sass-rails'
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Use Readline in the Rails Console
gem 'rb-readline', '~>0.5.0', require: 'readline'

gem 'haml'
gem 'html2haml'

# http://foundation.zurb.com/docs/
# gem 'compass-rails' #, github: 'milgner/compass-rails', branch: 'rails4'
gem 'zurb-foundation' #, '~> 4.0.0'

gem 'devise', github: 'plataformatec/devise'#, :branch => 'rails4'

gem 'cancan'

gem 'simple_form'

group :development do
  gem 'habtm_generator'
  gem 'better_errors'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :development, :test do
  gem 'rspec-rails'
  gem "shoulda-matchers"
  gem "capybara"
  gem "pry"
  gem "ffaker"
  gem 'factory_girl_rails'
  gem 'database_cleaner', '1.0.1'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
  gem 'cucumber-rails', require: false
  gem 'webrat'
end

group :darwin do
  # gem 'rb-fsevent' , :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'rb-fsevent', :require => false
end

gem 'rails_admin', github: 'sferik/rails_admin'

gem 'high_voltage'

gem 'friendly_id', '5.0.0.beta4' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

gem 'rails_12factor', group: :production

gem 'gritter', github: 'RobinBrouwer/gritter'
