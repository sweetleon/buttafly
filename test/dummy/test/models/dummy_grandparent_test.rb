require 'test_helper'

describe "DummyGrandparent" do 

   subject { DummyGrandparent }

  describe "db" do 

    specify "columns & types" do 

      must_have_column(:name)
      must_have_column(:dummy_address_id, :integer)
    end
  end

  describe "associations" do 

    specify "belongs to" do 

      must_belong_to(:dummy_address)
    end
  end

  describe "validations" do 

    it "requires associated address" do 
      
      dummy_grandparent = build(:dummy_grandparent, dummy_address_id: nil)
      dummy_grandparent.valid?.must_equal false
    end
  end


end