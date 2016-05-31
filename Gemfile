source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.rc1'
# Use sqlite3 as the database for Active Record
gem 'pg', '0.18.4'
# Use SCSS for stylesheets
gem 'sass-rails', '6.0.0.beta1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.1.1'
gem 'jquery_mobile_rails', '1.4.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'sprockets-rails', github: "rails/sprockets-rails"
gem 'sprockets', github: "rails/sprockets"

gem 'haml', '4.0.7'
gem 'faker', '1.6.3'
gem 'devise', '4.1.1'
gem 'devise_invitable', '1.6.0'
gem 'active_model_serializers', '~> 0.10.0'

gem "letter_opener", group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '9.0.0'
  gem 'pry'

  # RSpec for Rails-3+
	gem 'rspec-rails', '3.1.0'

	gem 'capistrano', '2.14.2'
  gem 'rvm-capistrano', '1.4.1', require: false
  gem 'capistrano_colors', '0.5.4', require: false
  gem 'capistrano-ext', '1.2.1', require: false
end


group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'unicorn', '4.8.2'
end
