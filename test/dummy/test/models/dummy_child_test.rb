require 'test_helper'

describe "DummyChild" do 

  subject { DummyChild }

  describe "db" do 

    specify "columns & types" do 

      must_have_column(:name)
      must_have_column(:dummy_parent_id, :integer)
      must_have_column(:dummy_tribe_id, :integer)
    end
  end

  describe "associations" do 

    specify "belongs to" do 

      must_belong_to(:dummy_parent)
      must_belong_to(:dummy_tribe)
    end
  end

  describe "validations" do 

    it "requires associated parent" do 
      
      dummy_child = build(:dummy_child, dummy_parent_id: nil)
      dummy_child.valid?.must_equal false
    end
  end
end
