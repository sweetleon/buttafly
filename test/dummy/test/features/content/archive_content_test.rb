require "test_helper"

feature "archive content" do

  before do 
    @existing_content = FactoryGirl.create(:originable)
    visit '/buttafly/contents'
  end
  
  scenario "success" do
    within("#show-file-#{@existing_content.id}") do
      click_button "archive" 
    end    
    assert_selector(".alert-box", text: "file has been removed")
  end
end