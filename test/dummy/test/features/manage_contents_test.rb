require "test_helper"

feature "manage content" do

  background do 
    visit '/buttafly/contents'
  end
  
  scenario "upload a spreadsheet" do
    within(".new-content-form") do
      fill_in 'Name', :with => 'getsome noirs'
      attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload spreadsheet"
    end
    page.assert_selector(".alert-box", text: "getsome noirs has been uploaded")
    Buttafly::Spreadsheet.where(name: "getsome noirs").size.must_equal 1
  end

  # scenario "target a spreadsheet to a model" do 

  #   existing_content = FactoryGirl.create(:spreadsheet) 
  #   within("#show-file-#{existing_content.id}") do 

  #     select "Review", from: "mapping_targetable_model"
  #     click_button "Create new mapping"
  #   end
  # end
end