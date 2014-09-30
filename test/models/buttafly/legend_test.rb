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

  describe "#get_origin_keys" do 

    it "must return keys from default model" do
      file = create(:imported_file)
      keys = subject.get_origin_keys(Buttafly::Spreadsheet, file.id )
      desired_keys = ["mother", "child", "grandparent"]
      (keys["data"] & desired_keys).size == keys["data"].size
    end
  end

  describe "#get_target_keys" do 

    it "must get keys from target model" do 
      keys = subject.get_target_keys(DummyChild)
      desired_keys = ["dummy_parent_id", "dummy_address_id", "name"]
      ((keys & desired_keys) == keys).must_equal true
    end
  end

  describe "#get_ancestors" do 

    it "#get_parent_models" do 
      parent_models = subject.get_parent_models(DummyChild)
      parent_models.must_equal [:dummy_parent, :dummy_address]
    end

    it "must order a model's ancestors for creation" do 
      ancestors = subject.get_ancestor_models(DummyChild)
      expected_ancestors = [
        
        "dummy_parent" => {
          "attrs" => ["name", "dummy_grandparent_id", "dummy_address_id"],
          "dummy_address" => {
            "attrs" => ["city"]
          },
          "dummy_grandparent" => {
            "attrs" => ["name"]
          }
        },
        "dummy_address" => { 
          "attrs" => ["city"]
        }
      ]
      ancestors.must_equal expected_ancestors
      # ancestors[:parents].must_equal ["name", "dummy_grandparent_id"]
      # ancestors[:parents][:dummy_address].must_equal "blah"
    end
  end
end
