require 'test_helper'

describe "Buttafly::Mapping" do 

  subject { Buttafly::Mapping }

  describe "db" do 

    specify "columns & types" do 

      must_have_column(:legend_id, :integer)
      must_have_column(:originable_id, :integer)
      must_have_column(:originable_type)
      must_have_column(:targetable_id, :integer)
      must_have_column(:targetable_type)
    end

    specify "indexes" do 

      must_have_index(:legend_id)
      must_have_index([:originable_id, :originable_type])
      must_have_index([:targetable_id, :targetable_type])
    end
  end

  describe "associations" do 

    specify "belongs to" do 

      must_belong_to(:legend)
      must_belong_to(:originable)
      must_belong_to(:targetable)
    end    
  end
end
