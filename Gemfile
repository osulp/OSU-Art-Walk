source 'https://rubygems.org'

ruby '2.1.2'

gem 'coffee-rails'
gem 'email_validator'
gem 'jquery-rails'
gem 'sqlite3'
gem 'rack-timeout'
gem 'rails', '4.1.1'
gem 'recipient_interceptor'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '3.1.0.rc2'
gem 'uglifier'
gem 'unicorn'
gem 'blacklight'
gem 'sunspot_rails'
# Draper for decoration.
gem 'draper', '~> 1.3'
#Carrierwave and Rmagick for photo viewing and storage
gem 'carrierwave'
gem 'rmagick', '~> 2.13.2', :require => false
#TinyMCE for text editing
gem 'tinymce-rails', '4.0.11'

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'awesome_print'
  gem 'jazz_hands', :github => "terrellt/jazz_hands"
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 2.14.0'
end

group :test do
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'newrelic_rpm', '>= 3.7.3'
end

gem "jettywrapper", "~> 1.7"
gem "devise"
gem "devise-guests", "~> 0.3"
