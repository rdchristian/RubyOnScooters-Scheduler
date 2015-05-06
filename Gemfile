source 'https://rubygems.org'
ruby '2.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Twitter Bootstrap
gem "bh" # Helpers for bootstrap
gem "therubyracer"
gem "less-rails"
gem "twitter-bootstrap-rails"

# Date validation in the models and ice_cube is a feature-rich recurrence library
gem "date_validator"
gem "ice_cube"
gem 'recurring_select' # ice_cube helpers

# Awesome responsive search form
gem "selectize-rails"

# A lightweight javascript date library for parsing, manipulating, and formatting dates
gem 'momentjs-rails', '>= 2.8.1'

gem 'bootstrap3-datetimepicker-rails', '~> 4.0.0'

# This ensures that any time you generate a resource, view, or mailer, you'll get Haml templates (instead of ERB)
gem "haml-rails"

gem 'haml'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks' # fixing issues between them
gem 'turboboost', github: 'waymondo/turboboost'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# postgresql
gem 'pg'

# enhanced querying framework
gem 'squeel'

# to allow attr_accessible to be used in rails 4 ('cause I'm lazy and don't wanna adapt to change...)
gem 'protected_attributes'

# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'

 #Scheduling jobs to run automatically
 gem 'whenever', require: false

 #For sending text messages
 gem 'twilio-ruby'

# Use Unicorn as the app server
# gem 'unicorn'

# Image uploader and resizing gems
gem 'carrierwave','~> 0.10.0'
gem 'mini_magick','~> 3.8.0'
gem 'fog','~>1.23.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'jasmine-rails' # if you plan to use JavaScript/CoffeeScript

  # Pretty printer with awesome capabilities!
  gem 'awesome_print'
end

# setup Cucumber, RSpec, autotest support
group :test do
  gem 'rspec-rails', '2.14'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels' # basic imperative step defs
  gem 'database_cleaner' # required by Cucumber
  gem 'autotest-rails'
  gem 'factory_girl_rails' # if using FactoryGirl
  gem 'metric_fu'        # collect code metrics
end

group :production do
  gem 'rails_12factor'
end
