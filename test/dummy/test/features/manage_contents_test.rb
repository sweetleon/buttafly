require "test_helper"

feature "create content" do
  
  given(:existing_content) { create(:spreadsheet) }

  background do 
    visit '/buttafly/contents'
  end
  
  scenario "success " do
    within(".new-content-form") do
      fill_in 'Name', :with => 'pinot noirs'
      attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload spreadsheet"
    end
    page.assert_selector(".alert-box", text: "pinot noirs has been uploaded")
    Buttafly::Spreadsheet.where(name: "pinot noirs").size.must_equal 1
  end
  
  scenario "fail renders message" do
skip
    within(".new-content-form") do
      # fill_in 'Name', :with => existing_content.name
      # attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload file"
    end
    page.assert_selector(".alert-box", text: "Could not upload content")
    Buttafly::Spreadsheet.where(name: "pinot noirs").size.must_equal 0
  end
end