require "test_helper"

feature "submit mapping data" do

  scenario "success" do 
    
    existing_content = FactoryGirl.create(:spreadsheet)
    mapping = existing_content.mappings.new(targetable_model: "Review", legend_data: nil)
    mapping.save
    visit '/buttafly/contents'
    within("#file-mapping-#{mapping.id}") do
      select('wine::name', from: "mapping[data][wine]")
      select('winery::name', from: "mapping[data][winery]")
      select('wine::vintage', from: "mapping[data][vintage]")
      select('content', from: "mapping[data][review]")
      select('rating', from: "mapping[data][rating]")
      click_button "map it"
    end

      
   # within("#show-file-#{existing_content.id}") do 

   #    select "Review", from: "mapping_targetable_model"
   #    click_button "Create new mapping"
   #  end
   #  page.assert_selector(".alert-box.success")
   #  existing_content.mappings.first.targetable_model.must_equal "Review"
  end
end