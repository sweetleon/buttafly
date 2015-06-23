require "test_helper"

feature "delete mapping" do
end 
feature "edit mapping" do 

end

feature "submit mapping data" do

  scenario "success" do 
    
    legends = {
      "wine" => "wine::name", 
      "winery" => "winery::name",
      "review" => "content",
      "vintage" => "wine::vintage",
      "rating" => "rating"
    }

    existing_content = FactoryGirl.create(:originable)
    mapping = existing_content.mappings.create(targetable_model: "Review", legend_data: nil)
    
    visit '/buttafly/contents'
    within("#file-mapping-#{mapping.id}") do
      legends.each_pair do |k,v|
        select(v, from: "mapping[data][#{k}]")
      end
      click_button("write legend")
    end
    page.assert_selector(".alert-box", text: "mapping updated")
    
    within("#file-mapping-#{mapping.id}") do

      legends.each_pair do |k,v|
        
        has_field?("mapping[data][#{k}]", with: v).must_equal true
      end
    end
    assert_selector(".label.panel-state-mapped")


  end
end