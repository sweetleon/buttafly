require "test_helper"

feature "archive content" do

  before do 
    @existing_content = FactoryGirl.create(:originable)
    visit '/buttafly/contents'
  end
  
  scenario "success" do
    within("#content-scope-all") do 

      within("#show-file-#{@existing_content.id}") do
        click_button "archive" 
      end
    end    
    assert_selector(".alert-box", text: /successfully archived/)
  end
end