require "test_helper"


describe "Buttafly::ApplicationHelper" do 

  describe "field_choices" do 

    it "must return the correct attributes" do 
      mapping = FactoryGirl.create(:mapping)
      assert_includes field_choices(mapping), "content"
      assert_includes field_choices(mapping), "rating"
      assert_includes field_choices(mapping), "wine::vintage"
      assert_includes field_choices(mapping), "wine::name"
    end
  end
end
