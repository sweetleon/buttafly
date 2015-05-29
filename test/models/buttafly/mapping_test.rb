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

  let(:mapping) { create(:mapping) }

  describe "get eligible models" do 

    it "#originable_models" do

      models = subject.originable_models
      models.first.must_equal "Buttafly::Spreadsheet"
    end

    it "#targetable_models" do 
      expected = [
        "DummyChild", 
        "DummyParent", 
        "DummyGrandparent",
        "DummyTribe", 
        "Review",
        "Winery",
        "Wine", 
        "User"
      ]
      models = subject.targetable_models
      models.must_equal (models & expected) 
    end

    it "#targetable_order" do 
      mapping.update(targetable_model: "DummyParent")
      mapping.targetable_order.must_equal [ :dummy_tribe, :dummy_grandparent, :dummy_parent]
    end

    it "self#targetable_order()" do 
      skip
      expected_order = [
        :dummy_tribe, 
        :dummy_grandparent, 
        :dummy_parent, 
        :dummy_child]
      subject.targetable_order.must_equal expected_order
    end

    it "self#targetable_order" do 
      expected_order = [:dummy_tribe, :dummy_grandparent]
      subject.targetable_order(:dummy_grandparent).must_equal expected_order
    end
  end

  describe "#get_origin_headers" do 

    it "must return headers" do 

      headers = mapping.get_origin_headers
      headers.must_equal ["child name", "parent name", "grandparent name", "tribe name", "age"]
    end 
  end
end 