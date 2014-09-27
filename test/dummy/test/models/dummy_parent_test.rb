require 'test_helper'

describe "DummyParent" do 

  subject { DummyParent }

  describe "db" do 

    specify "columns & types" do 
    
      must_have_column(:mother_name)
      must_have_column(:grandparent_id, :integer)
    end
  end

  describe "associations" do 

    specify "belongs to" do 
      must_belong_to(:grandparent)
    end

    specify "has many" do 

      must_have_many(:dummy_children)
      must_have_many(:dummy_grandchildren)
    end

  end
end
