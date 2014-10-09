require 'test_helper'

describe "Buttafly::LegendsController" do 

  before do 
    @routes = Buttafly::Engine.routes
  end

  let(:legend) { create(:legend) }
  let(:originable) { create(:spreadsheet) }

  it "should get new" do

    get :new, originable_id: originable.id
    assert_response :success
    assert_not_nil assigns(:originable)
    assert_not_nil assigns(:legend)
  end

  # it "should get show" do
  #   get :show, id: legend.id
  #   assert_response :success
  # end

  # it "should get edit" do
  #   get :edit, id: legend.id
  #   assert_response :success
  # end

  # it "should get index" do
  #   get :index
  #   assert_response :success
  # end
end
