require "test_helper"

feature "upload content" do

  background do
  end

  scenario "success" do
    skip
    visit '/buttafly'
    within(".new-content-form") do
      fill_in 'Name', :with => 'getsome noirs'
      attach_file( "originable_flat_file", "test/dummy/test/samples/family.odt.csv")
      click_button "Upload spreadsheet"
    end
    assert_selector(".alert", text: "getsome noirs has been uploaded")
    originable = Buttafly::Spreadsheet.where(name: "getsome noirs")
    originable.count.must_equal 1
    originable.last.aasm_state.must_equal "uploaded"
    assert_selector(".label.state-uploaded")
  end
end