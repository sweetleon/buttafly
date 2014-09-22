require 'test_helper'

describe "Buttafly::Legend" do 

  subject { Buttafly::Legend }

  describe "db" do 

    specify "columns & types" do 

      must_have_column(:cartographer_id, :integer)
      must_have_column(:data, :json)
    end

    describe "associations" do

      specify "belongs to" do

        must_belong_to(:cartographer)
      end

      specify "has many" do

        must_have_many(:mappings)
        must_have_many(:targetable)
        must_have_many(:originable)
      end 
    end
  end
end
