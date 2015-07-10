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

  let(:mapping) { create(:mapping, targetable_model: "Review") }

  describe "class methods" do 

    it "#self.originable_models" do
      models = subject.originable_models
      assert_equal models.first, "Buttafly::Spreadsheet"
    end

    it "#self.targetable_models" do 
      expected = ["DummyChild", "DummyParent", "DummyGrandparent", "DummyTribe", 
        "Review", "Winery", "Wine", "User"]
      models = subject.targetable_models
      models.must_equal (models & expected) 
    end
  end

  describe "originable methods" do 

    it "#originable_headers must return correct headers" do 
      headers = mapping.originable_headers
      headers.must_equal %w[wine winery vintage review rating]
    end 

    describe "#update_originable" do 

      it "first mapping must change aasm_state to :targeted" do
        originable = FactoryGirl.create(:originable)
        originable.targeted?.must_equal false
        originable.mappings.create(attributes_for(:mapping))
        originable.reload.targeted?.must_equal true
      end

      it "adding mapping data must change originable aasm_state to :mapped" do

        mapping = FactoryGirl.create(:mapping)
        mapping.originable.targeted?.must_equal true
        data = FactoryGirl.attributes_for(:mapping_with_data)[:legend_data]
        mapping.update(legend_data: data )
        mapping.originable.mapped?.must_equal true
      end
    end
  end

  describe "targetable methods" do 

    it "#targetable_parents" do 
      mapping.targetable_parents.must_equal [:user, :wine]
      mapping.targetable_parents(:user).must_equal []
      mapping.update(targetable_model: "DummyChild")
      mapping.targetable_parents().must_equal [:dummy_parent, :dummy_tribe]
    end

    it "" do 

    end

    describe "#targetable_order" do 
      
      it "simple" do 
        mapping.update(targetable_model: "Review")
        expected = { 
          :user => {}, 
          :wine => { 
            :winery => {}
          }
        }
        actual = mapping.targetable_order
        assert_equal expected, actual
      end

      it "complex" do 
        
        mapping.update(targetable_model: "DummyChild") 
        expected = { 
          :dummy_parent => { 
            :dummy_grandparent => { 
              :dummy_tribe => {}
            }, 
            :dummy_tribe => {}
          }, 
          :dummy_tribe => {}
        }
        actual = mapping.targetable_order
        assert_equal expected, actual
      end
    end
  end
end 
