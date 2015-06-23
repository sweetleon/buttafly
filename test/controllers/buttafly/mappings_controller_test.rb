 require 'test_helper'

describe "Buttafly::MappingsController" do 

  before do 
    @routes = Buttafly::Engine.routes
    request.env['HTTP_REFERER'] = "/referring/url"
  end    

  let(:originable)  { create(:originable) }
  let(:mapping)     { create(:mapping) }

  it "must POST #create" do 

    assert_difference "Buttafly::Mapping.count" do
      post :create, mapping: {
        originable_id: originable.id, 
        targetable_model: "Review"
      }
    end
    assert_response 302
  end

  describe "must PATCH #update" do 
    
    it "stores data" do 

      patch :update, id: mapping, mapping: { 
        "data"=> {
          "wine"=>"wine::name",
          "winery"=>"winery::name",
          "vintage"=>"wine::vintage",
          "review"=>"content",
          "rating"=>"rating"}
        }
      assert_response 302
      mapping.reload.legend_data.wont_equal nil
      mapping.legend_data.must_include ["wine", "wine::name"]
      mapping.legend_data.must_include ["review", "content"]
      mapping.legend_data.must_include ["winery", "winery::name"]
      mapping.originable.mapped?.must_equal true
    end

  end

  it "must 'DELETE' destroy" do 
    mapping
    assert_difference('Buttafly::Mapping.count', -1, 'An mapping must be destroyed') do
      delete :destroy, id: mapping
    end
  end  
end
