require 'test_helper'

describe "Buttafly::Mapping" do 

  subject { Buttafly::Mapping }

  describe "db" do 

    specify "columns & types" do 

      must_have_column(:legend_id, :integer)
      must_have_column(:originable_id, :integer)
      must_have_column(:originable_type)
      must_have_column(:targetable_model, :string)
    end

    specify "indexes" do 

      must_have_index(:legend_id)
      must_have_index([:originable_id, :originable_type])
    end
  end

  describe "associations" do 

    specify "belongs to" do 

      must_belong_to(:legend)
      must_belong_to(:originable)
    end    
  end

  describe "validations" do 

    it "must have a legend" do 

      mapping = create(:mapping)
      mapping.update(originable_id: nil)
      mapping.valid?.must_equal false
    end
  end

  let(:mapping) { create(:mapping, targetable_model: "Review") }

  describe "class methods" do 

    it "#self.originable_models" do
      models = subject.originable_models
      assert_equal models.first, "Buttafly::Spreadsheet"
    end

    it "#self.targetable_models" do 
      expected = ["DummyChild", "DummyParent", "DummyGrandparent", "DummyTribe", 
        "Review", "Winery", "Wine", "User"]
      models = subject.targetable_models
      models.must_equal (models & expected) 
    end
  end

  describe "originable methods" do 

    it "#originable_headers must return correct headers" do 
      headers = mapping.originable_headers
      headers.must_equal %w[wine winery vintage review rating]
    end 

    describe "#update_originable" do 

      it "first mapping must change aasm_state to :targeted" do
      skip 
        originable = FactoryGirl.create(:spreadsheet)
        originable.targeted?.must_equal false
        originable.mappings.create(attributes_for(:mapping))
        originable.reload.targeted?.must_equal true
      end

      it "adding mapping data must change originable aasm_state to :mapped" do

        mapping = FactoryGirl.create(:mapping)
        mapping.originable.targeted?.must_equal true
        mapping.update(legend_data: [])
        mapping.originable.mapped?.must_equal true
      end
    end
  end

  describe "targetable methods" do 

    it "#targetable_field_choices" do 
      
      mapping.update(targetable_model: "Review")
      actual = mapping.targetable_field_choices
      assert_includes actual, "rating"
      assert_includes actual, "wine::name"
      assert_includes actual, "winery::name"
    end

    it "#targetable_order" do 
      
      mapping.update(targetable_model: "Review")
      expected = { :user => [], :wine => [:winery] }
      actual = mapping.targetable_order
      assert_equal expected, actual
    end

    # it "self#targetable_order()" do 
    #   skip
    #   expected_order = [
    #     :wine, :reviewer]
    #   subject.targetable_order.must_equal expected_order
    # end

    # it "self#targetable_order()" do 
    #   skip
    #   expected_order = [:dummy_tribe, :dummy_grandparent]
    #   subject.targetable_order(:dummy_grandparent).must_equal expected_order
    # end
  end
end 



#   it "must respond to :targetable_attrs" do 
#     assert subject.respond_to? :targetable_attrs
#     assert_equal %w[rating content], subject.targetable_attrs
#   end
  
#   it "must respond to :targetable_fields" do
#   skip
#     assert subject.respond_to? :targetable_fields
#     assert_includes ["wine:name"], subject.targetable_fields
#   end 
# end

# 

# # [:dummy_child, e:dummy_parent, :dummy_grandparent].each do |factory|
# [:review].each do |factory|

#   let(:record) { create(factory) }
  
#   it "#targetable_attrs" do 
#     skip
#     record.targetable_attrs.must_include "content"
#     record.targetable_attrs.wont_include "dummy_tribe_id"
#   end

#   it "#self.targetable_attrs" do 
#     skip
#     record.class.targetable_attrs.must_include "name"
#     record.class.targetable_attrs.wont_include "dummy_tribe_id"
#   end


  
# end
# end