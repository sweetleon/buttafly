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
end 