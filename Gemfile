source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "acts_as_list", "~> 0.9.19"
gem "bootsnap", ">= 1.4.2", require: false
gem "fast_jsonapi", "~> 1.5"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rack-cors", "~> 1.0.3"
gem "rails", "~> 6.0.0"
gem "scenic", "~> 1.5.1"
gem "sidekiq", "~> 6.4.0"

group :development, :test do
  gem "byebug", platforms: :mri
  gem "rspec-rails", "~> 3.8"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
end
