require 'test_helper'

module Buttafly

  class ContentsControllerTest < ActionDispatch::IntegrationTest

    include Engine.routes.url_helpers

    # before do
    #   # @request.env['HTTP_REFERER'] = "/referring/url"

    #   @routes = Engine.routes
    # end
    # before do
    #   # @request.env['HTTP_REFERER'] = "/referring/url"

    #   @routes = Engine.routes
    # end

    let(:originable) { FactoryGirl.create(:uploaded_file) }

    # it "get #show must assign @originable" do

    #   get :show, id: originable.id
    #   assert_response :success
    #   assert_not_nil assigns(:originable)
    # end

  #   it "get #edit" do

  #     get :edit, id: originable.id
  #     assert_response :success
  #     assert_not_nil assigns(:originable)
  #   end

  #   it "post #create" do

  #     post :create, originable: {
  #       name: "slick name",
  #       flat_file: "slickname.csv"
  #     }
  #     assert_response 302
  #   end

  #   it "post #create saves a spreadsheet" do

  #     attrs = attributes_for(:originable)
  #     assert_difference "Buttafly::Spreadsheet.counbuttaflyt" do
  #       post :create, originable: attrs
  #     end
  #   end

    it "should get index" do
skip
      get contents_url
      assert_response :success
      # assert_not_nil assigns :contents
    end

  #   it "must GET :destroy" do

  #     delete :destroy, id: originable.id
  #     assert_response 302
  #   end

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

