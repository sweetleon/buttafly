require "test_helper"

feature "upload content" do

  background do 
    visit '/buttafly/contents'
  end
  
  scenario "success" do
    within(".new-content-form") do
      fill_in 'Name', :with => 'getsome noirs'
      attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload spreadsheet"
    end
    page.assert_selector(".alert-box", text: "getsome noirs has been uploaded")
    originable = Buttafly::Spreadsheet.where(name: "getsome noirs")
    originable.size.must_equal 1
    assert_selector(".panel.panel-state-uploaded")
  end
end