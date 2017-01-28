require "test_helper"

feature "upload content" do

  background do
  end

  scenario "success" do
    visit '/buttafly'
    within(".new-content-form") do
      fill_in 'Name', :with => 'getsome noirs'
      attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload spreadsheet"
    end
    assert_selector(".alert", text: "has been uploaded")
    originable = Buttafly::Spreadsheet.where(name: "getsome noirs")
    originable.count.must_equal 1
    originable.last.aasm_state.must_equal "uploaded"
  end
end