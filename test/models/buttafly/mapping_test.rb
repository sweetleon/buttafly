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
      expected = ["DummyChild", "DummyParent", "DummyGrandparent"]
      models = subject.targetable_models
      models.must_equal (models & expected) 
    end
  end

  describe "#get_origin_headers" do 

    it "must return headers" do 

      headers = mapping.get_origin_headers
      headers.must_equal %w[child parent grandparent tribe]
    end
  end
end 