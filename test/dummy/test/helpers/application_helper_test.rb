require "test_helper"


describe "Buttafly::ApplicationHelper" do 

  describe ":mapping_form_builder()" do 

    let(:mapping) { FactoryGirl.create(:mapping) } 
    
    it "with Review as :targetable_model" do 
      mapping.update(targetable_model: "Review")
      expected_array = mapping_form_builder(nil, mapping.targetable_order)
      assert_includes expected_array, [:wine, :winery]
      assert_includes expected_array, [:user] 
    end

    it "with DummyChild as :targetable_model" do 
      mapping.update(targetable_model: "DummyChild")
      expected_array = mapping_form_builder(nil, mapping.targetable_order)
      refute_includes expected_array, [:dummy_parent] 
      refute_includes expected_array, [:dummy_parent, :dummy_grandparent] 
      assert_includes expected_array, [:dummy_parent, :dummy_grandparent, :dummy_tribe] 
      assert_includes expected_array, [:dummy_parent, :dummy_tribe] 
      assert_includes expected_array, [:dummy_tribe] 
    end
  end

  describe ":mapping_form_select()" do 

    it "without array" do 
      
      actual = mapping_form_select(mapping, :content)
      id = /mapping_data_review_content/ 
      name = /name="mapping\[data\]\[review\]\[content\]"><option/
      assert_match id, actual
      assert_match name, actual
    end

    it "with array" do 

      actual = mapping_form_select(mapping, :name, [:wine], :wine )
      id = /mapping_data_review_wine_name/ 
      name = /name="mapping\[data\]\[review\]\[wine\]\[name\]"><option/
      assert_match id, actual
      assert_match name, actual
    end

    it "with array targeted to first spot" do 
      
      actual = mapping_form_select(mapping, :name, [:wine, :winery], :wine )
      id = /mapping_data_review_wine_name/ 
      name = /name="mapping\[data\]\[review\]\[wine\]\[name\]"><option/
      assert_match id, actual
      assert_match name, actual
    end

    it "with array targeted to second spot" do 
      
      actual = mapping_form_select(mapping, :name, [:wine, :winery], :winery )
      id = /mapping_data_review_wine_winery_name/ 
      name = /name="mapping\[data\]\[review\]\[wine\]\[winery\]\[name\]"><option/
      assert_match id, actual
      assert_match name, actual
    end

    it "with array targeted to third spot" do 
      mapping.update(targetable_model: "DummyChild")
      actual = mapping_form_select(mapping, :name, 
        [:dummy_parent, :dummy_grandparent, :dummy_tribe], :dummy_tribe )
      id = /mapping_data_dummy_child_dummy_parent_dummy_grandparent_dummy_tribe/
      name = /\[dummy_child\]\[dummy_parent\]\[dummy_grandparent\]\[dummy_tribe\]\[name\]"/
      assert_match id, actual
      assert_match name, actual
    end
  end
end
