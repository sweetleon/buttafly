require "test_helper"

feature "destroy content" do

  before do 
    @existing_content = FactoryGirl.create(:originable)
    visit '/buttafly/contents'
  end
  
  scenario "success" do
    save_and_open_page
    within("#show-file-#{@existing_content.id}") do
      click_button "remove file" 

    end
    save_and_open_page
    
    assert_selector(".alert-box", text: "file has been removed")


    # save_and_open_page
  end
end