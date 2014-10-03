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

    describe "self.get_ancestors" do 

      let(:ancestors) { subject.get_ancestors(DummyChild) } 
      let(:parent) { ancestors[:parents].first[:dummy_parent] }
      let(:grandparent) { parent[:parents].first[:dummy_grandparent] }

      it "should return :attrs and :parents keys" do 

        ancestors.keys.must_equal [:attrs, :parents]
      end
        
      it "should hold the parent model's attrs" do 

        expected_attrs = ["name", "dummy_parent_id", "dummy_tribe_id"]
        ancestors[:attrs].must_equal expected_attrs 
      end

      it "should have nested parents" do 
        keys = ancestors[:parents].map(&:keys).flatten
        keys.must_equal [:dummy_parent, :dummy_tribe]
      end

      it "should have nested grandparents" do
        expected_attrs = ["name", "dummy_grandparent_id", "dummy_tribe_id"]
        parent[:attrs].must_equal expected_attrs
      end 
      
      it "should have nested grandparents" do
        expected = [{:dummy_tribe=>{:attrs=>["name"], :parents=>[]}}]
        grandparent[:parents].must_equal expected 
      end
    end
  end
end
