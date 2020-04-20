source 'https://rubygems.org'

  git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
    "https://github.com/#{repo_name}.git"
  end

gem 'rails', '~> 5.0.2'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
  group :development, :test do
    gem 'byebug', platform: :mri
  end

  group :development do
    gem 'web-console', '>= 3.3.0'
  end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'ionicons-rails'
gem 'chartkick'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'adminlte-rails'
source 'http://insecure.rails-assets.org/' do
  gem 'rails-assets-admin-lte'
end
