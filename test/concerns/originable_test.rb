require 'test_helper'

describe "Buttafly::Originable" do 

  subject { Buttafly::Spreadsheet }

  it "must return true for originable models" do 
    subject.originable?.must_equal true
  end

  it "self.targetable_models" do 

    actual = subject.targetable_models
    expected = ["DummyChild", "DummyGrandparent", "DummyParent", "DummyTribe", 
                "Review", "User", "Wine", "Winery"]
    assert_equal actual, expected
  end
end