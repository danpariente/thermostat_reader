source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bootsnap", ">= 1.4.2", require: false
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rack-cors", "~> 1.0.3"
gem "rails", "~> 6.0.0"

group :development, :test do
  gem "byebug", platforms: :mri
  gem "rspec-rails", "~> 3.8"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
