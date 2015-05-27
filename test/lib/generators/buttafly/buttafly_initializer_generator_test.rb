require 'test_helper'
require 'generators/buttafly_initializer/buttafly_initializer_generator'

module Buttafly
  class ButtaflyInitializerGeneratorTest < Rails::Generators::TestCase
    tests ButtaflyInitializerGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
