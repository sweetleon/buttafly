require 'test_helper'

describe "Buttafly::ContentsController" do 

  before do 
    @request.env['HTTP_REFERER'] = "/referring/url"

    @routes = Buttafly::Engine.routes
  end

  let(:spreadsheet) { create(:uploaded_file) }

  it "get #show must assign @originable" do

    get :show, id: spreadsheet.id
    assert_response :success
    assert_not_nil assigns(:originable)
  end
  
  it "get #edit" do
    get :edit, id: spreadsheet.id
    assert_response :success
    assert_not_nil assigns(:originable)
  end

  it "post #create" do
    post :create, originable: { 
      name: "slick name",
      flat_file: "slickname.csv"
    }
    assert_response 302
  end
  
  # it "patch #import saves a spreadsheet" do
  #   skip
  #   request.env['HTTP_REFERER'] = "/referring/url"
  #   patch :import, id: spreadsheet.id, originable_type: "Buttafly::Spreadsheet"
  # end

  it "post #create saves a spreadsheet" do
skip
    assert_difference "Buttafly::Spreadsheet.count" do
      post :create, originable: { 
        name: "sweeet name",
        flat_file: "summer.csv"
      }
    end
  end
  
  it "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns :contents
  end

  it "must GET :destroy" do 
skip
    delete :destroy, id: spreadsheet.id
    assert_response 302

  end
end


