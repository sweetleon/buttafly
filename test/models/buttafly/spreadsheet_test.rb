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
    end
  end

  describe "validations" do 

    specify "presence of flat_file" do 

      sheet = subject.new(flat_file: nil)
      sheet.save
      assert !sheet.valid?
    end

    specify "uniqueness of flat_file and name" do 
skip
      existing_sheet = FactoryGirl.create(:spreadsheet)
      new_sheet = FactoryGirl.build(:spreadsheet, name: existing_sheet.name)
      new_sheet.save
      assert !new_sheet.valid?
    end
  end

  describe "states" do 

    specify "initial must be :uploaded" do 

      uploaded_file = subject.new
      uploaded_file.uploaded?.must_equal true
    end

    describe "permissions for" do 

      it ":uploaded" do
  
        file = build_stubbed(:uploaded_file)
        # file.may_import?.must_equal true
        # file.may_publish?.must_equal false
        # file.may_unpublish?.must_equal false
      end

      it ":imported" do 
  
        file = build_stubbed(:imported_file)
        # file.may_import?.must_equal true
        file.may_publish?.must_equal true
        file.may_unpublish?.must_equal false
      end

      it ":published" do 

        file = create(:published_file)
        # file.may_import?.must_equal false
        # file.may_publish?.must_equal false
        # file.may_unpublish?.must_equal true
      end
    end

    describe "events" do

      describe "#import!" do 

        let(:file) { create(:uploaded_file) }
      
        it "#convert_data_to_json!" do
skip
          file.convert_data_to_json!
          file.data.first["child name"].must_equal "ella mac"
          file.data.first["parent name"].must_equal "sara"
          file.data.first["grandparent name"].must_equal "kc shekhar"        
        end

        it "must populate data column with json" do 
skip
          file.import!
          file.data.first.wont_equal nil
          file.data.size.must_equal 2 
          file.aasm_state.must_equal "imported"
        end
      end
    end
  end
end
