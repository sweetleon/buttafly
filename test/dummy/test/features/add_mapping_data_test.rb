require "test_helper"

feature "replicate spreadsheet rows" do 

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

    existing_content = FactoryGirl.create(:spreadsheet)
    mapping = existing_content.mappings.create(targetable_model: "Review", legend_data: nil)
    
    visit '/buttafly/contents'
    within("#file-mapping-#{mapping.id}") do
      legends.each_pair do |k,v|
        select(v, from: "mapping[data][#{k}]")
      end
      click_button "map!"
    end
    page.assert_selector(".alert-box", text: "mapping updated")
    
    within("#file-mapping-#{mapping.id}") do

      legends.each_pair do |k,v|
        
        has_field?("mapping[data][#{k}]", with: v).must_equal true
      end
    end
    assert_selector(".panel.panel-state-mapped")


  end
end