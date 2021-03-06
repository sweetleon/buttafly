$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buttafly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buttafly"
  s.version     = Buttafly::VERSION
  s.authors     = ["Frederick D. Schoeneman"]
  s.email       = ["fred.schoeneman@gmail.com"]
  s.homepage    = "https://github.com/schadenfred/buttafly"
  s.summary     = "Map spreadsheet data into your app."
  s.description = "Upload a spreadsheet, map its headers to your columns, and create database objects with the correct associations."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "haml-rails"
  s.add_dependency "pg"
  s.add_dependency "aasm"
  s.add_dependency "carrierwave"
  s.add_dependency "jquery-rails"
  s.add_dependency "foundation-rails"
  s.add_dependency "roo"
  s.add_dependency "sass"
  s.add_dependency "kaminari"
  s.add_dependency "simple_form"
  s.add_dependency "factory_girl_rails"
  
  # development & testing
  s.add_development_dependency "minitest-rails-capybara"
  s.add_development_dependency "launchy"
  s.add_development_dependency "guard-minitest"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-livereload"
  s.add_development_dependency "byebug"
  s.add_development_dependency "better_errors"
  s.add_development_dependency "binding_of_caller"
end
