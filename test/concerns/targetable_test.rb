require 'test_helper'

describe "Buttafly::targetable" do 

  [Review].each do |targetable_model|

    subject { targetable_model }

    it "must return true for #{targetable_model}" do 
      subject.targetable.must_equal true
    end

    it "must have one :mapping" do 
      must_have_one(:mapping)
    end

    it "must respond to :belongs_to_cols" do
      skip
      assert subject.respond_to? :belongs_to_cols
      assert_equal [:reviewer, :wine], subject.belongs_to_cols
    end

    it "must respond to :targetable_attrs" do 
      assert subject.respond_to? :targetable_attrs
      assert_equal %w[rating content], subject.targetable_attrs
    end
    
    it "must respond to :targetable_fields" do
    skip
      assert subject.respond_to? :targetable_fields
      assert_includes ["wine:name"], subject.targetable_fields
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

    it "#self.parent_models" do 
      record.class.parent_models.must_include :dummy_parent
    end
  end
end