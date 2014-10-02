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
      desired_keys = ["dummy_parent_id", "dummy_tribe_id", "name"]
      ((keys & desired_keys) == keys).must_equal true
    end
  end

  describe "#get_ancestors" do 

    it "#get_parent_models" do 
      parent_models = subject.get_parent_models(DummyChild)
      parent_models.must_equal [:dummy_parent, :dummy_tribe]
    end

    it "must order a model's ancestors for creation" do 
      ancestors = subject.get_ancestor_models(DummyChild)
      ancestors.class.must_equal Array
      ancestors.count.must_equal 2
      ancestors.map(&:keys).flatten.must_equal [:dummy_parent, :dummy_tribe]
      parents = ancestors.first
      parents[:dummy_parent][:attrs].must_equal ["name", "dummy_grandparent_id", "dummy_tribe_id"]
      parents[:dummy_parent].must_equal "blah"
      # parents[:dummy_parent][:parents].map(&:keys).must_equal "blah"
      # grandparents = ancestors.first[:parents]
      # grandparents.must_equal "blah"
      # ancestors.first[:parents].must_equal [:dummy_grandparent, :dummy_tribe]
      # grandparents.first# ancestors.first[:dummy_parent][:parents].must_equal [:dummy_grandparent, :dummy_tribe]
      # ancestors[:dummy_parent][:attrs].must_include "name"
      # parent_models.first[:dummy_parent][:parents].must_equal "blah"
      # expected_ancestors = [
        
      #   :dummy_parent => {
      #     :attrs => ["name", "dummy_grandparent_id", "dummy_tribe_id"],
      #     :dummy_tribe => {
      #       :attrs => ["city"]
      #     },
      #     :dummy_grandparent => {
      #       :attrs => ["name"],
      #       :dummy_tribe => {
      #         :attrs => ["city"]
      #       }
      #     }
      #   },
      #   :dummy_tribe => { 
      #     :attrs => ["city"]
      #   }
      # ]
      # ancestors.must_equal 
      # ancestors[:parents].must_equal ["name", "dummy_grandparent_id"]
      # ancestors[:parents][:dummy_tribe].must_equal "blah"
    end
  end
end
