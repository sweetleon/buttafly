require 'test_helper'

describe "Buttafly::Originable" do 

  subject { Buttafly::Spreadsheet }

  it "must return true for originable models" do 
    subject.originable?.must_equal true
  end
end