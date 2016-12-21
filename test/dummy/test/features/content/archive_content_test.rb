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
        click_button "archive"
      end
    end
    assert_selector(".alert", text: /successfully archived/)
  end
end