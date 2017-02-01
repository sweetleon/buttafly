require 'test_helper'

module Buttafly

  class ContentsControllerTest < ActionDispatch::IntegrationTest

    include Engine.routes.url_helpers

    let(:originable) { FactoryGirl.create(:uploaded_file) }

    describe "post #create saves a spreadsheet" do

      Given(:attrs) { attributes_for(:originable) }
      Given(:make_request) { post contents_url, params: { originable: attrs } }

      Then do
        assert_difference "Buttafly::Spreadsheet.count" do
          make_request
        end
      end
    end

    describe "must GET :destroy" do

      Given(:originable) { create(:originable) }
      Given { delete content_path(originable) }

      Then { assert_response :redirect }
      And { assert Buttafly.originable.where(id: originable.id).empty? }
    end

    describe "must PATCH :map" do

      Given(:originable) { create(:originable) }
      Given { patch map_content_path(originable), params: { blah: "blah" } }

      Then { assert_response :redirect }
      # And { assert Buttafly.originable.where(id: originable.id).empty? }

    end

  #   it "patch #archive" do

  #     patch :archive, id: originable.id
  #     assert_response 302
  #     assert originable.reload.archived?
  #   end

  #   it "patch #transmogrify" do
  # skip
  #     originable = FactoryGirl.create(:mapped_file)
  #     patch :transmogrify, id: originable.id
  #     assert_response 302
  #     assert originable.reload.transmogrified?
  #   end

  #   it "patch #archive" do
  # # skip
  # #     patch :archive, id: originable.id
  # #     assert_response 302
  # #     assert originable.reload.archived?
  #   end
  end
end

