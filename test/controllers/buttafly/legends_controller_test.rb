require 'test_helper'

describe "Buttafly::LegendsController" do 

  before do 
    @routes = Buttafly::Engine.routes
  end

  let(:legend) { create(:legend) }
  let(:mapping) { create(:mapping) }

  describe "GET #new" do 

    before do 
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

    it "must create a new legend" do 
      get :create, mapping_id: mapping.id

    end
  end
end
