require 'test_helper'

describe "Buttafly::ContentsController" do 

  before do 
    @routes = Buttafly::Engine.routes
  end

  let(:spreadsheet) { create(:not_imported_file) }

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
  
  it "patch #import saves a spreadsheet" do
    request.env['HTTP_REFERER'] = "/referring/url"
    patch :import, id: spreadsheet.id, originable_type: "Buttafly::Spreadsheet"
  end

  it "post #create saves a spreadsheet" do
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
    # assert_not_nil assigns :legend
    # assert_not_nil assigns :legends
    assert_not_nil assigns :contents
    # assert_not_nil assigns :originable
  end
end




#     test "should get update" do
#       get :update
#       assert_response :success
#     end

#     test "should gendet destroy" do
#       get :destroy
#       assert_response :success
#     end


#   end
# end
