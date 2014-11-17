require 'test_helper'

describe "Factories" do 

	FactoryGirl.factories.map(&:name).each do |factory_name|
	  describe "#{factory_name}" do
	    it 'is valid' do
	      FactoryGirl.build(factory_name).valid?.must_equal true
	    end
	  end
	end
end