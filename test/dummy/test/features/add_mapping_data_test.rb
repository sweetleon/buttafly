require "test_helper"

feature "submit mapping data" do

  scenario "success" do 
    mapping = FactoryGirl.create(:mapping) 
    existing_content = mapping.originable
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