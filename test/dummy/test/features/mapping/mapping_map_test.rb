require "test_helper"

feature "delete mapping" do
end 
feature "edit mapping" do 

end

feature "submit mapping data" do

  scenario "success" do 
skip    
    legends = {
      "wine" => "wine::name", 
      "winery" => "winery::name",
      "review" => "content",
      "vintage" => "wine::vintage",
      "rating" => "rating"
    }

    existing_content = FactoryGirl.create(:targeted_file)
    mapping = existing_content.mappings.create(attributes_for(:mapping))
    
    visit '/buttafly/contents'

    within("#content-scope-all") do 
      within("#file-mapping-#{mapping.id}") do
        legends.each_pair do |k,v|
          select(v, from: "mapping[data][#{k}]")
        end
        click_button("write legend")
      end
    end
    assert_selector(".alert-box", text: "mapping updated")
    
    within("#content-scope-all") do 
      within("#file-mapping-#{mapping.id}") do
        legends.each_pair do |k,v|
          has_field?("mapping[data][#{k}]", with: v).must_equal true
        end
      end
    end
    assert_selector(".label.state-mapped")


  end
end