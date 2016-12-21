require "test_helper"

feature "destroy content" do


  scenario "success" do
skip
    @existing_content = FactoryGirl.create(:originable)
    visit '/buttafly'
    within("#content-scope-uploaded") do
      within("#show-file-#{@existing_content.id}") do
        click_button "Remove File"
      end
    end
    assert_selector(".alert", text: /success/)
  end
end