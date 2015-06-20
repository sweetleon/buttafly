require "test_helper"

feature "create new mapping" do

  scenario "success" do 

    existing_content = FactoryGirl.create(:spreadsheet) 
    visit '/buttafly/contents'
    within("#show-file-#{existing_content.id}") do 

      select "Review", from: "mapping_targetable_model"
      click_button "Create new mapping"
    end
    page.assert_selector(".alert-box.success")
    existing_content.mappings.first.targetable_model.must_equal "Review"
    assert_selector(".panel.panel-state-targeted")

  end
end