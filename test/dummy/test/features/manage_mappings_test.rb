require "test_helper"

feature "create mapping" do
  
  given(:existing_content) { create(:spreadsheet) }

  background do 
    existing_content
    visit '/buttafly/contents'
  end
  
  scenario "success" do
    existing_content.mappings.count.must_equal 0
    within("#show-file-#{existing_content.id}") do 
      select("DummyChild", from: "mapping_targetable_model")
      click_button "Select Target Model"
    end
    page.assert_selector(".alert-box", text: "mapping created")
    existing_content.mappings.count.must_equal 1
    mapping = existing_content.mappings.first
    mapping.targetable_model.must_equal "DummyChild"
    mapping.originable.must_equal existing_content
  end
end

