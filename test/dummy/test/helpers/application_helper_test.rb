require "test_helper"


describe "Buttafly::ApplicationHelper" do 

  describe "field_choices" do 

    let(:mapping) { FactoryGirl.create(:mapping) } 
    
    it "must return the correct attributes" do 
      skip
      assert_includes field_choices(mapping), "content"
      assert_includes field_choices(mapping), "rating"
      assert_includes field_choices(mapping), "wine::vintage"
      assert_includes field_choices(mapping), "wine::name"
    end

    it ":mapping_form_builder()" do 
      mapping.update(targetable_model: "Review")
      expected_array = mapping_form_builder(nil, mapping.targetable_order)
      assert_includes expected_array, [:wine, :winery]
      assert_includes expected_array, [:user] 
    end

    it ":mapping_form_builder()" do 
      mapping.update(targetable_model: "DummyChild")
      expected_array = mapping_form_builder(nil, mapping.targetable_order)
      refute_includes expected_array, [:dummy_parent] 
      refute_includes expected_array, [:dummy_parent, :dummy_grandparent] 
      assert_includes expected_array, [:dummy_parent, :dummy_grandparent, :dummy_tribe] 
      assert_includes expected_array, [:dummy_parent, :dummy_tribe] 
      assert_includes expected_array, [:dummy_tribe] 
    end

    it "without array" do 
      skip
      actual = mapping_form_select(mapping, :content)
      assert_equal actual, nil
    end

    it "with array" do 
skip
      actual = mapping_form_select(mapping, :name, [:wine], :wine )
      assert_match actual, nil
    end

    it "with array" do 
      
      actual = mapping_form_select(mapping, :name, [:wine, :winery], :wine )
      assert_match actual, nil
    end
  end
end
