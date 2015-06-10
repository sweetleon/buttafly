require "test_helper"

feature "submit mapping data" do

  scenario "success" do 
    mapping = FactoryGirl.create(:mapping) 
    existing_content = mapping.originable
    visit '/buttafly/contents'
    page.find("#show-file-#{existing_content.id}")
      .find('table').find('thead').find('tr').find('td', text: "HEADERS")
    # page.find("#show-file-#{existing_content.id} table tbody tr td", text: "Review")
    within("#show-file-#{existing_content.id} table tbody tr") do
      find('td', text: "Review")
      find('td select')
    end

      
   # within("#show-file-#{existing_content.id}") do 

   #    select "Review", from: "mapping_targetable_model"
   #    click_button "Create new mapping"
   #  end
   #  page.assert_selector(".alert-box.success")
   #  existing_content.mappings.first.targetable_model.must_equal "Review"
  end
end