require "test_helper"

feature "create new mapping" do

  scenario "success" do
skip
    existing_content = FactoryGirl.create(:originable)
    visit '/buttafly/contents'
    within("#content-scope-all") do
      within("#show-file-#{existing_content.id}") do
        select "Review", from: "mapping_targetable_model"
        click_button "create new mapping"
      end
    end
    page.assert_selector(".alert-box.success")
    existing_content.mappings.first.targetable_model.must_equal "Review"
    assert_selector(".label.state-targeted")

  end
end