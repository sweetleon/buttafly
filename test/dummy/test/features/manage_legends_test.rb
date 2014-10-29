require "test_helper"

feature "create legend" do

  given(:mapping) { create(:mapping)}
  background do 
    mapping
    visit '/buttafly/contents'
  end

  scenario "success" do
    within("#show-file-#{mapping.originable_id}") do 
      click_link "new legend"
    end
    # save_and_open_page
    # page.assert_selector(".alert-box", text: "mapping created")
    # existing_content.mappings.count.must_equal 1
    # mapping = existing_content.mappings.first
    # mapping.targetable_model.must_equal "DummyChild"
    # mapping.originable.must_equal existing_content
    # within()
  end
end