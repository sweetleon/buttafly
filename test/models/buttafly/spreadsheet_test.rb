require 'test_helper'
  
  describe "Buttafly::Spreadsheet" do 

  subject { Buttafly::Spreadsheet }

  describe "db" do 

    specify "columns & types" do

      must_have_column(:data, :json)
      must_have_column(:name, :string)
      must_have_column(:user_id, :integer)
      must_have_column(:imported_at, :datetime)
      must_have_column(:processed_at, :datetime)
      must_have_column(:aasm_state, :string)
      must_have_column(:source_row_count, :integer)
      must_have_column(:mtime, :integer)
    end

    specify "indexes" do 
    
      must_have_index(:aasm_state)
      must_have_index(:imported_at)
      must_have_index(:processed_at)
      must_have_index(:user_id)
      must_have_index(:name)
    end
  end

  describe "associations" do 

    specify "belongs to" do 
  
      must_belong_to(:user)
    end

    specify "has many" do 
  
      must_have_many(:legends)
      must_have_many(:mappings)
      must_have_many(:targetable)
    end
  end

  describe "states" do 

    specify "initial must be :not_imported" do 

      not_imported_file = subject.new
      not_imported_file.not_imported?.must_equal true
    end

    describe "permissions for" do 

      it ":not_imported" do
  
        file = build_stubbed(:not_imported_file)
        file.may_import?.must_equal true
        file.may_publish?.must_equal false
        file.may_unpublish?.must_equal false
      end

      it ":imported" do 
  
        file = build_stubbed(:imported_file)
        file.may_import?.must_equal true
        file.may_publish?.must_equal true
        file.may_unpublish?.must_equal false
      end

      it ":published" do 

        file = build_stubbed(:published_file)
        file.may_import?.must_equal false
        file.may_publish?.must_equal false
        file.may_unpublish?.must_equal true
      end
    end

    describe "events" do

      describe "#import!" do 

        let(:file) { create(:not_imported_file) }
      
        it "#convert_data_to_json!" do
          file.convert_data_to_json!
          file.data.first["child"].must_equal "Childe Harold"
          file.data.first["mother"].must_equal "Momma Sue"
          file.data.first["grandparent"].must_equal "Crotchety Carl"        
        end

        it "must populate data column with json" do 
          file.import!
          file.data.first.wont_equal nil
          file.data.size.must_equal 1 
          file.aasm_state.must_equal "imported"
        end
      end
    end
  end
end
