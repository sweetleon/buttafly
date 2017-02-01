require 'test_helper'

module Buttafly

  class MappingsControllerTest < ActionDispatch::IntegrationTest

    include Engine.routes.url_helpers

    let(:originable)  { create(:originable, name: "") }
    # let(:mapping)     { create(:mapping) }

    describe "must POST #create" do

      Given(:make_request) { post mappings_url, params: { mapping: {
          originable_id: originable.id,
          targetable_model: "Review" }
        }, headers: { "HTTP_REFERER" => "/referring/url" }

      }

      Then do
        assert_difference "Buttafly::Mapping.count" do
          make_request
        end
      end

      And { originable.reload.aasm_state.must_equal "mapped" }
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
end