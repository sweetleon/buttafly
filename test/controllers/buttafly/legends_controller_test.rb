require 'test_helper'

describe "Buttafly::LegendsController" do 

  before do 
    @routes = Buttafly::Engine.routes
  end

  let(:legend) { create(:legend) }
  let(:mapping) { create(:mapping) }

  describe "GET #new" do 

    before do 
      skip
      get :new, mapping_id: mapping.id
    end

    it "must succeed" do 
      assert_response 200
    end

    it "must instantiate a legend from existing mapping" do 
      assert_not_nil assigns(:legend)
      assert_not_nil assigns(:mapping)
      assert_not_nil assigns(:new_record)
    end
  end

  describe "POST #create" do 

    it "must be successful" do
      post :create, legend: {"dummy_tribe"=>{"name"=>"tribe name"}}  
      assert_response 302
    end

    it "must add a new legend" do 

      assert_difference('Buttafly::Legend.count', 1) do
        post :create, legend: {"dummy_tribe"=>{"name"=>"tribe name"}}  
      end
    end
  end
end
