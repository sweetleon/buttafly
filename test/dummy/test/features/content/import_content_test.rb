require "test_helper"

feature "archive content" do

  before do
    @existing_content = FactoryGirl.create(:originable)
    visit '/buttafly/contents'
  end

  scenario "success" do
skip
    within("#content-scope-uploaded") do

      within("#show-file-#{@existing_content.id}") do
        click_button "import"
      end
    end
    Buttafly::Spreadsheet.last.may_wipe?.must_equal true

    assert_selector(".alert", text: /successfully imported/)
    within("#content-scope-uploaded") do

      within("#show-file-#{@existing_content.id}") do
        click_button "wipe"
      end
    end
    Buttafly::Spreadsheet.last.may_import?.must_equal true

  end
end