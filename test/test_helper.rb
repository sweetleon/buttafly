# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

Dir[File.expand_path('test/support/*.rb')].each { |file| require file }

require File.expand_path("../../test/dummy/config/environment.rb", __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require "rails/test_help"
require "minitest/rails/capybara"
require "minitest/given"
require "byebug"
require "factory_girl_rails"
require 'database_cleaner'
require "buttafly"



# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new


# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end


include TestMatchers
include FactoryGirl::Syntax::Methods
# include Warden::Test::Helpers

DatabaseCleaner.strategy = :deletion

# class Minitest::Spec
#   before :each do
#     DatabaseCleaner.start
#   end

#   # after { Warden.test_reset! }
#   after :each do
#     DatabaseCleaner.clean
#     Warden.test_reset!
#   end
# end

# # with the minitest-around gem, this may be used instead:
# class Minitest::Spec
#   around do |tests|
#     DatabaseCleaner.cleaning(&tests)
#   end
# end

