$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "buttafly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "buttafly"
  s.version     = Buttafly::VERSION
  s.authors     = ["Frederick D. Schoeneman"]
  s.email       = ["fred.schoeneman@gmail.com"]
  s.homepage    = ""
  s.summary     = "Map spreadsheet data into your app."
  s.description = "Buttafly is a Rails engine designed to create ActiveRecord 
    objects from spreadsheet rows and columns."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "haml-rails", "~> 0.5.3"
  s.add_dependency "pg"
  s.add_dependency "aasm"
  s.add_dependency "carrierwave"
  s.add_dependency "jquery-rails"
  s.add_dependency "foundation-rails"
  s.add_dependency "roo"
  s.add_dependency "sass"
  s.add_dependency "kaminari"
  
  # development & testing
  s.add_development_dependency "minitest-spec-rails"
  s.add_development_dependency "minitest-rails-capybara"
  s.add_development_dependency "launchy"
  s.add_development_dependency "pry"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "guard-minitest"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-livereload"

end
