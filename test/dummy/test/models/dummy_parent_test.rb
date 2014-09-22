require 'test_helper'

describe "DummyParent" do 

  subject { DummyParent }

  describe "db" do 

    specify "columns & types" do 


      must_have_column(:mother_name)
      must_have_column(:father_name)
    end
  end

end
