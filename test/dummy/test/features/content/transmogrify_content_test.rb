require "test_helper"

feature "transmogrify content" do

  before do
    @existing_content = FactoryGirl.create(:mapped_file)
    @existing_content.mappings.create(FactoryGirl.attributes_for(:mapping_with_legend))
    # visit '/buttafly/contents'
  end

  scenario "success" do
skip
    save_and_open_page
    within("#content-scope-all") do
      within("#show-file-#{@existing_content.id}") do
        click_button "transmogrify"
      end
    end
    assert_selector(".alert-box", text: /success/)
  end
end