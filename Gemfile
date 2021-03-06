source 'https://rubygems.org'
ruby '2.4.2'

# Backend
gem 'rails', '5.1.4' # Latest stable
gem 'pg', '< 1.0' # Use Postgresql as database
gem 'puma' # Use Puma as the app server
gem 'active_model_serializers' # ActiveModel::Serializer implementation and Rails hooks
gem 'carrierwave' # Classier solution for file uploads for Rails
gem 'carrierwave-aws' # Use the officially supported AWS-SDK library for S3 storage
gem 'mini_magick' # A ruby wrapper for ImageMagick or GraphicsMagick command line
gem 'kaminari' # A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Rails 3 and 4
gem 'chronic' # Chronic is a pure Ruby natural language date parser.
gem 'paranoia', '2.3.1' # Paranoia is a re-implementation of acts_as_paranoid for Rails 3 and Rails 4. Soft-deletion of records
gem 'ffaker' # A library for generating fake data such as names, addresses, and phone numbers.
gem 'fabrication' # Fabrication generates objects in Ruby. Fabricators are schematics for your objects, and can be created as needed anywhere in your app or specs.
gem 'sidekiq' # background processing for Ruby
gem 'draper' # object-oriented layer of presentation logic
gem 'config' # Config helps you easily manage environment specific settings in an easy and usable manner.

# Admin
gem 'rails_admin'

# Authentications & Authorizations
gem 'devise' # Authentication solution for Rails with Warden
gem 'pundit' # Minimal authorization through OO design and pure Ruby classes
gem 'omniauth-google-oauth2'
gem 'doorkeeper'

# Assets
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'font-awesome-sass' # Font-Awesome Sass gem for use in Ruby/Rails projects
gem 'sass-rails' # SASS
gem 'uglifier'
gem 'bootstrap-sass'

group :development do
  gem 'better_errors' # Better error page for Rails and other Rack apps
  gem 'binding_of_caller' # Retrieve the binding of a method's caller in MRI 1.9.2+
  gem 'awesome_print' # Pretty print your Ruby objects with style -- in full color and with proper indentation
  gem 'guard-rubocop'
  gem 'roadie-rails' # Mailers
  gem 'rubycritic', require: false # A Ruby code quality reporter
  gem 'brakeman', require: false # A static analysis security vulnerability scanner for Ruby on Rails applications
end

group :development, :test do
  gem 'bullet' # help to kill N+1 queries and unused eager loading
  gem 'figaro' # Simple Rails app configuration
  gem 'rspec-rails' # Rails testing engine
  gem 'guard-rspec' # Auto-run specs
  gem 'shoulda-matchers' # Tests common Rails functionalities
  gem 'capybara' # Integration testing
  gem 'selenium-webdriver', '3.7.0' # Ruby bindings for Selenium/WebDriver
  gem 'database_cleaner' # Use Database Cleaner

  gem 'pry-rails' # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'spring' # Spring speeds up development by keeping your application running in the background.
  gem 'spring-commands-rspec' # This gem implements the rspec command for Spring.
  gem 'spring-watcher-listen', '2.0.1' # Makes Spring watch the filesystem for changes using Listen
  gem 'listen', '3.1.5' # Listens to file modifications
  gem 'letter_opener' # Preview mail in the browser instead of sending.

  gem 'sassc-rails' # Gem to generate scss source maps

  gem 'pronto'
  gem 'pronto-rubocop', require: false
  gem 'pronto-flay', require: false # analyzes code for structural similarities
  gem 'pronto-brakeman', require: false # analyzes code for security vulnerabilities
  gem 'pronto-dirty_words', require: false # analyzes code for  Seven Dirty Words
  gem 'pronto-rails_best_practices', require: false
  gem 'pronto-rails_schema', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-scss', require: false
  gem 'pronto-eslint_npm', require: false
end

group :test do
  gem 'webmock' # Library for stubbing and setting expectations on HTTP requests in Ruby
  gem 'simplecov', require: false # code coverage analysis tool for Ruby
  gem 'vcr' # Gem for recording test suite's HTTP interactions
  gem 'timecop' # Gem for time travel
  gem 'json_matchers' # Validate the JSON returned by your Rails JSON APIs
  gem 'rspec-retry' # Retry randomly failing rspec example.
  gem 'rails-controller-testing' # add helpers for template testing
end

group :production do
  gem 'rack-timeout'           # Rack middleware which aborts requests that have been running for longer than a specified timeout.
end
