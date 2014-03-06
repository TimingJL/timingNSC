source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :production do
  gem 'mysql2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'mechanize'
gem 'nokogiri'

gem 'watir'

# Delayed::Job (or DJ) encapsulates the common pattern of asynchronously executing longer tasks in the background.
gem 'daemons'
gem 'delayed_job_active_record'

# Gemfile for Rails 3, Rails 4, Sinatra, and Merb
gem 'will_paginate', '~> 3.0'

# This gem integrates the Twitter Bootstrap pagination component with the will_paginate pagination gem.
gem 'will_paginate-bootstrap', '0.2.5'

# Bootstrap is a toolkit designed to kickstart development of webapps and sites. It includes base CSS and HTML for typography, forms, buttons, tables, grids, navigation, and more.
gem "twitter-bootstrap-rails"

# Rails forms made easy.
gem 'simple_form'

# Google cloud message
gem 'gcm'

# Zip generator
gem 'rubyzip'

# Google search
gem 'google-search'

# Apache Solr full-text search engine
gem 'sunspot_rails'
# gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development
group :development do
	gem 'sunspot_solr'
end

# Client side validation
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

group :development, :test do
    gem 'railroady'
    gem "rails-erd"
end
