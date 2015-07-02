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

    it ":build_mapping_form(mapping)" do 

      # assert_equal build_mapping_form(mapping), "blah"
    end
  end
end
