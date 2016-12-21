 require 'test_helper'

describe "Buttafly::MappingsController" do

  before do
    @routes = Buttafly::Engine.routes
    # request.env['HTTP_REFERER'] = "/referring/url"
  end

  let(:originable)  { create(:originable) }
  let(:mapping)     { create(:mapping) }

  it "must POST #create" do
skip
    assert_difference "Buttafly::Mapping.count" do
      post :create, mapping: {
        originable_id: originable.id,
        targetable_model: "Review"
      }
    end
    assert_response 302
  end

  describe "must PATCH #update" do

    let(:legend) do
      FactoryGirl.attributes_for(:mapping_with_legend)[:legend]
    end

    it "stores data" do
      skip
      patch :update, id: mapping, mapping: { "legend" => legend }
      assert_response 302
      mapping.reload.legend.wont_equal nil
      mapping.legend["review"]["rating"].must_equal "rating"
      mapping.legend["review"]["content"].must_equal "review"
      mapping.legend["review"]["wine"]["vintage"].must_equal "vintage"
      mapping.legend["review"]["wine"]["winery"]["name"].must_equal "winery"
      mapping.originable.mapped?.must_equal true
    end

  end

  it "must 'DELETE' destroy" do
    skip
    mapping
    assert_difference('Buttafly::Mapping.count', -1, 'An mapping must be destroyed') do
      delete :destroy, id: mapping
    end
  end
end
