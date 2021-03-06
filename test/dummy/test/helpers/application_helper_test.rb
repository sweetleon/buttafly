require "test_helper"


describe "Buttafly::ApplicationHelper" do 

  let(:mapping) { FactoryGirl.create(:mapping) } 
  
  describe ":mapping_form_builder()" do \
    
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

  let(:base_name) { "mapping\[legend\]\[#{target_model}\]" }
  let(:base_id) { "mapping_legend_#{target_model}_" }

  describe ":mapping_form_select()" do

    describe "options" do 

      let(:target_model) { "review" }

      describe "with legend empty" do


      end

      describe "with legend empty" do 

        it "no matching header should be blank" do 
skip
          actual = mapping_form_select(mapping, :rating, [], :review)
          # selected = "<option selected=\"selected\" value=\"rating\">rating</option>"    
          selected = "blah"
          assert_match selected, actual
        end
      end
    end 

    describe "review as target" do 

      let(:target_model) { "review" }

      describe "without legend data" do 
    
        it "without array" do 
    
          actual = mapping_form_select(mapping, :content)
          assert_match base_id + "content", actual
          assert_match base_name + "\[content\]", actual
        end

        it "with array" do 
  
          actual = mapping_form_select(mapping, :name, [:wine], :wine )
          assert_match base_id + "wine_name", actual
          assert_match base_name + "\[wine\]\[name\]", actual
        end

        it "with array targeted to first spot" do 
  
          actual = mapping_form_select(mapping, :name, [:wine, :winery], :wine )
          assert_match base_id + "wine_name", actual
          assert_match base_name + "\[wine\]\[name\]", actual
        end

        it "with array targeted to second spot" do 
            
          actual = mapping_form_select(mapping, :name, [:wine, :winery], :winery )
          assert_match base_id + "wine_winery_name", actual
          assert_match base_name + "\[wine\]\[winery\]\[name\]", actual
        end
      end
      
      describe "with legend data" do
        let(:mapping) { FactoryGirl.create(:mapping_with_data) }
   
        it "without array" do 
    skip
          actual = mapping_form_select(mapping, :content)
          assert_match base_id + "content", actual
          assert_match base_name + "\[content\]", actual
          assert_match "blah", actual
        end
      end 
    end

    describe "DummyChild as target" do 

      let(:target_model) { "dummy_child" }

      it "with array targeted to third spot" do 

skip
        mapping.update(targetable_model: "DummyChild")
        actual = mapping_form_select(mapping, :name, 
          [:dummy_parent, :dummy_grandparent, :dummy_tribe], :dummy_tribe )
        name = "\[dummy_parent\]\[dummy_grandparent\]\[dummy_tribe\]\[name\]"
        id = "dummy_parent_dummy_grandparent_dummy_tribe"
        assert_match base_id + id, actual
        assert_match base_name + name, actual
      end
    end
  end
end
