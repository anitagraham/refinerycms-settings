source "https://rubygems.org"

gemspec

git "https://github.com/refinery/refinerycms", branch: "master" do
  gem "refinerycms"

  group :test do
    gem 'refinerycms-testing'
  end
end

# Database Configuration
unless ENV["TRAVIS"]
  gem "activerecord-jdbcsqlite3-adapter", platform: :jruby
  gem "sqlite3", platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  group :mysql do
    gem 'activerecord-jdbcmysql-adapter', '>= 1.3.0.rc1', platform: :jruby
    gem 'mysql2', '~> 0.5', platform: :ruby
  end
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  group :postgres, :postgresql do
    gem 'activerecord-jdbcpostgresql-adapter', '>= 1.3.0.rc1', platform: :jruby
    gem 'pg', '~> 0.21', platform: :ruby
  end
end

gem "jruby-openssl", platform: :jruby

# Refinery/rails should pull in the proper versions of these
group :assets do
  gem "coffee-rails"
  gem "uglifier"
end

group :development do
  gem 'listen'
end


group :test do
  gem 'generator_spec', '~> 0.9.3'
  gem 'launchy'
  gem 'coveralls', require: false
  gem 'rspec-retry'
  gem 'puma'
  gem 'capybara-email', '~> 3.0'
  gem 'poltergeist'

  # TODO: Use beta source for Rails 6 support
  gem 'rspec-rails', '~> 4.0.0.beta3'
end


# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path("../.gemfile", __FILE__)
  eval File.read(local_gemfile)
end
