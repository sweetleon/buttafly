require 'test_helper'

describe "Buttafly::MappingsController" do 

  before do 
    @routes = Buttafly::Engine.routes
  end    

  let(:originable) { create(:spreadsheet) }
  let(:mapping) { create(:mapping) }

  it "must POST #create" do 
 
    request.env['HTTP_REFERER'] = "/referring/url"
    post :create, mapping: {
      originable_id: originable.id, 
      targetable_model: "DummyChild"
    }
    assert_response 302
    m = originable.mappings.first
    m.targetable_model.must_equal "DummyChild"
  end

  it "must 'DELETE' destroy" do 
    mapping
    request.env['HTTP_REFERER'] = "/referring/url"
    assert_difference('Buttafly::Mapping.count', -1, 'An mapping must be destroyed') do
      delete :destroy, id: mapping
    end
  end  
end
