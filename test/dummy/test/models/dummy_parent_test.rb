require 'test_helper'

describe "DummyParent" do 

  subject { DummyParent }

  describe "db" do 

    specify "columns & types" do 
    
      must_have_column(:name)
      must_have_column(:dummy_grandparent_id, :integer)
      must_have_column(:dummy_address_id, :integer)
    end
  end

  describe "associations" do 

    specify "belongs to" do 

      must_belong_to(:dummy_grandparent)
    end

    specify "has many" do 

      must_have_many(:dummy_children)
      must_have_many(:dummy_grandchildren)
    end

  end

  describe "validations" do 

    it "requires associated grandparent" do 

      dummy_parent = build(:dummy_parent, dummy_grandparent_id: nil)
      dummy_parent.valid?.must_equal false
    end
  end 
end
