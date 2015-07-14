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
    
    let(:legend_data) do
      FactoryGirl.attributes_for(:mapping_with_data)[:legend_data]
    end
    
    it "stores data" do 

      patch :update, id: mapping, mapping: { "legend_data" => legend_data }
      assert_response 302
      mapping.reload.legend_data.wont_equal nil
      mapping.legend_data["review"]["rating"].must_equal "rating"
      mapping.legend_data["review"]["content"].must_equal "review"
      mapping.legend_data["review"]["wine"]["vintage"].must_equal "vintage"
      mapping.legend_data["review"]["wine"]["winery"]["name"].must_equal "winery"
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
