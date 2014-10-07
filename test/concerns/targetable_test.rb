require 'test_helper'

describe "Buttafly::targetable" do 

  [DummyChild, DummyParent, DummyGrandparent].each do |targetable_model|

    subject { targetable_model }

    it "must return true for #{targetable_model}" do 
      subject.targetable.must_equal true
    end

    it "must have one :mapping" do 
      must_have_one(:mapping)
    end
  end
end