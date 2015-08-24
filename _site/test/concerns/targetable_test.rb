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

  # [:dummy_child, e:dummy_parent, :dummy_grandparent].each do |factory|
  [:dummy_child].each do |factory|

    let(:record) { create(factory) }
    
    it "#targetable_attrs" do 
      record.targetable_attrs.must_include "name"
      record.targetable_attrs.wont_include "dummy_tribe_id"
    end

    it "#self.targetable_attrs" do 
      record.class.targetable_attrs.must_include "name"
      record.class.targetable_attrs.wont_include "dummy_tribe_id"
    end
  end
end